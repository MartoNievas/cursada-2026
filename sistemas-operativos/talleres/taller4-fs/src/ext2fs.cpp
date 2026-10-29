#include "ext2fs.h"

#include <cassert>
#include <cstddef>
#include <cstring>
#include <future>
#include <iomanip>
#include <iostream>

#include "hdd.h"
#include "pentry.h"
Ext2FS::Ext2FS(HDD &disk, unsigned char pnumber)
    : _hdd(disk), _partition_number(pnumber) {
  assert(pnumber <= 3);

  // Load Superblock
  unsigned char *buffer = new unsigned char[2 * SECTOR_SIZE];

  // Get partition info
  const PartitionEntry &pentry = _hdd[_partition_number];

  // Skip first two sectors & read 3rd and 4th sectors
  // Warning: We assume common sector size of 512 bytes but it may not be true
  _hdd.read(pentry.start_lba() + 2, buffer);
  _hdd.read(pentry.start_lba() + 3, buffer + SECTOR_SIZE);

  // Warning: this only works in Little Endian architectures
  _superblock = (struct Ext2FSSuperblock *)buffer;

  // Load Block Group Table

  // Compute amount of block groups in FS 
  _block_groups = _superblock->blocks_count / _superblock->blocks_per_group;
  if ((_superblock->blocks_count % _superblock->blocks_per_group) != 0)
    _block_groups++;

  // Allocate enough memory to keep the table
  _bgd_table = new Ext2FSBlockGroupDescriptor[_block_groups];

  // Since the size of the table is not forced to be a factor of SECTOR_SIZE
  // we need to compute the amount of sectors we should read and then copy
  // one by one the descriptors into the table in the appropriate order.
  unsigned int size_of_bgd_table =
      sizeof(Ext2FSBlockGroupDescriptor) * _block_groups;
  unsigned int bgd_table_sectors = size_of_bgd_table / SECTOR_SIZE;
  if ((size_of_bgd_table % SECTOR_SIZE) != 0)
    bgd_table_sectors++;

  buffer = new unsigned char[bgd_table_sectors * SECTOR_SIZE];
  for (unsigned int i = 0; i < bgd_table_sectors; i++)
    _hdd.read(pentry.start_lba() + 4 + i, buffer + SECTOR_SIZE * i);

  // Copy descriptors into table
  for (unsigned int i = 0; i < _block_groups; i++)
    _bgd_table[i] = *(
        (Ext2FSBlockGroupDescriptor *)(buffer +
                                       i * sizeof(Ext2FSBlockGroupDescriptor)));
  delete[] buffer;
}

unsigned int Ext2FS::blockgroup_for_inode(unsigned int inode) {
  assert(inode > 0);
  return (inode - 1) / _superblock->inodes_per_group;
}

unsigned int Ext2FS::blockgroup_inode_index(unsigned int inode) {
  assert(inode > 0);
  return (inode - 1) % _superblock->inodes_per_group;
}

// Free allocated memory
Ext2FS::~Ext2FS() {
  delete[] reinterpret_cast<unsigned char *>(_superblock);
  delete[] _bgd_table;
}

struct Ext2FSSuperblock *Ext2FS::superblock() { return _superblock; }

unsigned int Ext2FS::block_groups() { return _block_groups; }

struct Ext2FSBlockGroupDescriptor *Ext2FS::block_group(unsigned int index) {
  assert(index < _block_groups);
  return &_bgd_table[index];
}

/**
 * Helpers para imprimir en hexa sin dejar output en ese modo.
 */
static void print_hex(std::ostream &output, const char *name,
                      unsigned int value) {
  std::ios::fmtflags flags = output.flags();
  output << name << ": 0x" << std::hex << value << std::endl;
  output.flags(flags);
}

static void print_hex_bytes(std::ostream &output, const char *name,
                            const unsigned char *bytes, unsigned int count) {
  std::ios::fmtflags flags = output.flags();
  char fill = output.fill('0');
  output << name << ": " << std::hex;
  for (unsigned int i = 0; i < count; i++)
    output << std::setw(2) << (unsigned int)bytes[i];
  output << std::endl;
  output.fill(fill);
  output.flags(flags);
}

std::ostream &operator<<(std::ostream &output,
                         const struct Ext2FSInode &inode) {
  print_hex(output, "mode", inode.mode);
  output << "uid: " << inode.uid << std::endl;
  output << "size: " << inode.size << std::endl;
  output << "atime: " << inode.atime << std::endl;
  output << "ctime: " << inode.ctime << std::endl;
  output << "mtime: " << inode.mtime << std::endl;
  output << "dtime: " << inode.dtime << std::endl;
  output << "gid: " << inode.gid << std::endl;
  output << "links_count: " << inode.links_count << std::endl;
  output << "blocks: " << inode.blocks << std::endl;
  print_hex(output, "flags", inode.flags);
  output << "os_dependant_1: " << inode.os_dependant_1 << std::endl;

  for (unsigned int i = 0; i < 15; i++)
    output << "block[" << i << "]: " << inode.block[i] << std::endl;

  output << "generation: " << inode.generation << std::endl;
  output << "file_acl: " << inode.file_acl << std::endl;
  output << "directory_acl: " << inode.directory_acl << std::endl;
  output << "faddr: " << inode.faddr << std::endl;
  for (unsigned int i = 0; i < 3; i++)
    output << "os_dependant_2[" << i << "]: " << inode.os_dependant_2[i]
           << std::endl;

  return output;
}

std::ostream &operator<<(std::ostream &output,
                         const struct Ext2FSSuperblock &superblock) {
  output << "inodes_count: " << superblock.inodes_count << std::endl;
  output << "blocks_count: " << superblock.blocks_count << std::endl;
  output << "reserved_blocks_count: " << superblock.reserved_blocks_count
         << std::endl;
  output << "free_blocks_count: " << superblock.free_blocks_count << std::endl;
  output << "free_inodes_count: " << superblock.free_inodes_count << std::endl;
  output << "first_data_block: " << superblock.first_data_block << std::endl;
  output << "log_block_size: " << superblock.log_block_size << std::endl;
  output << "log_fragment_size: " << superblock.log_fragment_size << std::endl;
  output << "blocks_per_group: " << superblock.blocks_per_group << std::endl;
  output << "fragments_per_group: " << superblock.fragments_per_group
         << std::endl;
  output << "inodes_per_group: " << superblock.inodes_per_group << std::endl;
  output << "mount_time: " << superblock.mount_time << std::endl;
  output << "write_time: " << superblock.write_time << std::endl;
  output << "mount_count: " << superblock.mount_count << std::endl;
  output << "max_mount_count: " << superblock.max_mount_count << std::endl;
  print_hex(output, "magic_bytes", superblock.magic_bytes);
  output << "state: " << superblock.state << std::endl;
  output << "errors: " << superblock.errors << std::endl;
  output << "minor_revision_level: " << superblock.minor_revision_level
         << std::endl;
  output << "lastcheck: " << superblock.lastcheck << std::endl;
  output << "checkinterval: " << superblock.checkinterval << std::endl;
  output << "creator_os: " << superblock.creator_os << std::endl;
  output << "revision_level: " << superblock.revision_level << std::endl;
  output << "default_reserved_userid: " << superblock.default_reserved_userid
         << std::endl;
  output << "default_reserved_groupid: " << superblock.default_reserved_groupid
         << std::endl;
  // -- EXT2_DYNAMIC_REV Specific --
  output << "first_inode: " << superblock.first_inode << std::endl;
  output << "inode_size: " << superblock.inode_size << std::endl;
  output << "block_group_number: " << superblock.block_group_number
         << std::endl;
  print_hex(output, "feature_compatibility", superblock.feature_compatibility);
  print_hex(output, "feature_incompatibility",
            superblock.feature_incompatibility);
  print_hex(output, "readonly_feature_compatibility",
            superblock.readonly_feature_compatibility);
  print_hex_bytes(output, "uuid", (const unsigned char *)superblock.uuid,
                  sizeof(superblock.uuid));
  output << "volume_name: ";
  for (int i = 0; i < 16; i++)
    output << superblock.volume_name[i];
  output << std::endl;
  output << "last_mounted: ";
  for (int i = 0; i < 64; i++)
    output << superblock.last_mounted[i];
  output << std::endl;
  print_hex(output, "algo_bitmap", superblock.algo_bitmap);
  // Performance hints
  output << "prealloc_blocks: " << (unsigned int)superblock.prealloc_blocks
         << std::endl;
  output << "prealloc_dir_blocks: "
         << (unsigned int)superblock.prealloc_dir_blocks << std::endl;
  // Journaling support
  print_hex_bytes(output, "journal_uuid",
                  (const unsigned char *)superblock.journal_uuid,
                  sizeof(superblock.journal_uuid));
  output << "journal_inode: " << superblock.journal_inode << std::endl;
  output << "journal_device: " << superblock.journal_device << std::endl;
  output << "last_orphan: " << superblock.last_orphan << std::endl;
  // Directory indexing support
  print_hex_bytes(output, "hash_seed",
                  (const unsigned char *)superblock.hash_seed,
                  sizeof(superblock.hash_seed));
  output << "default_hash_version: "
         << (unsigned int)superblock.default_hash_version << std::endl;
  // Other options
  print_hex(output, "default_mount_options", superblock.default_mount_options);
  output << "first_meta_bg: " << superblock.first_meta_bg << std::endl;

  return output;
}

std::ostream &
operator<<(std::ostream &output,
           const struct Ext2FSBlockGroupDescriptor &bg_descriptor) {
  output << "block_bitmap: " << bg_descriptor.block_bitmap << std::endl;
  output << "inode_bitmap: " << bg_descriptor.inode_bitmap << std::endl;
  output << "inode_table: " << bg_descriptor.inode_table << std::endl;
  output << "free_blocks_count: " << bg_descriptor.free_blocks_count
         << std::endl;
  output << "free_inodes_count: " << bg_descriptor.free_inodes_count
         << std::endl;
  output << "used_dirs_count: " << bg_descriptor.used_dirs_count << std::endl;

  return output;
}

std::ostream &operator<<(std::ostream &output,
                         const struct Ext2FSDirEntry &dent) {
  output << "inode: " << dent.inode << std::endl;
  output << "record_length: " << dent.record_length << std::endl;
  output << "name_length: " << (unsigned short)dent.name_length << std::endl;
  output << "file_type: " << (unsigned short)dent.file_type << std::endl;

  // NULL terminate dent name
  char *dentname = new char[dent.name_length + 1];
  strncpy(dentname, dent.name, dent.name_length);
  dentname[dent.name_length] = '\0';

  output << "name: " << dentname << std::endl;

  delete[] dentname;

  return output;
}

/**
 * load_inode() reserva con "new unsigned char[]", así que hay que liberar
 * por el mismo camino. Un "delete inode" a secas es un mismatch.
 */
static void free_inode(struct Ext2FSInode *inode) {
  delete[] reinterpret_cast<unsigned char *>(inode);
}

struct Ext2FSInode *Ext2FS::inode_for_path(const char *path) {
  char *mypath = new char[strlen(path) + 1];
  mypath[strlen(path)] = '\0';
  strncpy(mypath, path, strlen(path));

  char *pathtok = strtok(mypath, PATH_DELIM);
  struct Ext2FSInode *inode = NULL;

  while (pathtok != NULL) {
    // Si todavía quedan componentes, el actual tiene que ser un
    // directorio. Si no, el path entero no existe (por ejemplo
    // "/grupos/g1/nota.txt/loquesea").
    if (inode != NULL && !INODE_ISDIR(inode)) {
      free_inode(inode);
      inode = NULL;
      break;
    }

    struct Ext2FSInode *prev_inode = inode;
    inode = get_file_inode_from_dir_inode(prev_inode, pathtok);

    if (prev_inode != NULL)
      free_inode(prev_inode);

    // Este componente no existe: no seguimos. Si siguiéramos, la
    // próxima vuelta llamaría a get_file_inode_from_dir_inode(NULL,
    // ...), que por convención arranca de la raíz, y "/noexiste/grupos"
    // terminaría resolviendo a "/grupos".
    if (inode == NULL)
      break;

    pathtok = strtok(NULL, PATH_DELIM);
  }

  delete[] mypath;
  return inode;
}

unsigned int Ext2FS::blockaddr2sector(unsigned int block) {
  // Get partition info
  const PartitionEntry &pentry = _hdd[_partition_number];

  // Compute block size by shifting the value 1024
  unsigned int block_size = 1024 << _superblock->log_block_size;
  unsigned int sectors_per_block = block_size / SECTOR_SIZE;

  return pentry.start_lba() + block * sectors_per_block;
}

void Ext2FS::read_block(unsigned int block_address, unsigned char *buffer) {
  unsigned int block_size = 1024 << _superblock->log_block_size;
  unsigned int sectors_per_block = block_size / SECTOR_SIZE;
  for (unsigned int i = 0; i < sectors_per_block; i++)
    _hdd.read(blockaddr2sector(block_address) + i, buffer + i * SECTOR_SIZE);
}

/**
 * Warning: This method allocates memory that must be freed by the caller
 */
struct Ext2FSInode *Ext2FS::load_inode(unsigned int inode_number) {

  // Atributos del superbloque para no hardcodear tamaños
  unsigned int inode_size = _superblock->inode_size;
  unsigned int block_size = 1024 << _superblock->log_block_size;

  // Obtenemos el índice del inodo dentro de su grupo y el número de block group
  unsigned int inode_index_in_group = blockgroup_inode_index(inode_number);
  unsigned int blockgroup_number = blockgroup_for_inode(inode_number);

  // Descriptor del grupo para obtener la ubicación de su tabla de inodos
  struct Ext2FSBlockGroupDescriptor *block_group_descriptor =
      (struct Ext2FSBlockGroupDescriptor *)block_group(blockgroup_number);

  // Bloque donde inicia la tabla de inodos de este grupo
  unsigned int inode_table_block = block_group_descriptor->inode_table;

  // Desplazamiento en bytes dentro de la tabla de inodos
  unsigned int offset_in_table = inode_index_in_group * inode_size;

  // Bloque de disco donde cae el inodo y su offset relativo dentro de ese bloque
  unsigned int inode_block = inode_table_block + (offset_in_table / block_size);
  unsigned int offset_in_block = offset_in_table % block_size;

  // Leemos el bloque completo del disco
  unsigned char *buffer = new unsigned char[block_size];
  read_block(inode_block, buffer);

  // Copiamos la estructura del inodo a memoria dinámica propia
  unsigned char *result = new unsigned char[sizeof(struct Ext2FSInode)];
  memcpy(result, buffer + offset_in_block, sizeof(struct Ext2FSInode));
  delete[] buffer;

  return (struct Ext2FSInode *)result;
}

unsigned int Ext2FS::get_block_address(struct Ext2FSInode *inode,
                                       unsigned int block_number) {

  unsigned int address_size = sizeof(inode->block[0]);
  unsigned int block_size = 1024 << _superblock->log_block_size;
  unsigned int addresses_per_block = block_size / address_size;

  if (block_number <= 11) {
    // Directo
    return inode->block[block_number];
  }
  
  // Posición relativa dentro de la indirección simple
  block_number -= 12;

  if (block_number < addresses_per_block) {
    // Bloque no asignado (sparse file)
    if (inode->block[12] == 0) {
      return 0;
    }

    unsigned char *buffer = new unsigned char[block_size];
    read_block(inode->block[12], buffer);
    unsigned int address = ((unsigned int *)buffer)[block_number];
    delete[] buffer;
    return address;
  }

  // Posición relativa dentro de la indirección doble
  block_number -= addresses_per_block;
  if (block_number < addresses_per_block * addresses_per_block) {
    // Bloque no asignado (sparse file)
    if (inode->block[13] == 0) {
      return 0;
    }

    unsigned char *buffer = new unsigned char[block_size];

    // Leemos la tabla de indirección doble (primer nivel)
    read_block(inode->block[13], buffer);

    unsigned int table_index_lvl1 = block_number / addresses_per_block;
    unsigned int table_index_lvl2 = block_number % addresses_per_block;
    unsigned int block_address_lvl2 = ((unsigned int *)buffer)[table_index_lvl1];

    // Chequeo de hueco intermedio antes de intentar leer
    if (block_address_lvl2 == 0) {
      delete[] buffer;
      return 0;
    }

    // Leemos la tabla de indirección simple (segundo nivel)
    read_block(block_address_lvl2, buffer);

    // Obetenmos el address del bloque casteando el buffer
    unsigned int address = ((unsigned int *)buffer)[table_index_lvl2];

    // Borramos la memoria que reservamos para guardar la tabla de bloques
    delete[] buffer;
    return address;
  }
  
  return 0;
}

struct Ext2FSInode *
Ext2FS::get_file_inode_from_dir_inode(struct Ext2FSInode *from,
                                      const char *filename) {
  // Si from es NULL arrancamos de la raíz. En ese caso el inodo lo
  // cargamos acá, así que también lo liberamos acá.
  bool from_is_root = (from == NULL);
  if (from_is_root)
    from = load_inode(EXT2_RDIR_INODE_NUMBER);
  assert(INODE_ISDIR(from));
  // Inicializamos la variable para guardar el resultado                                      
  struct Ext2FSInode *result = NULL;
  
  // Variables auxiliares para calculos
  unsigned int block_size = 1024 << _superblock->log_block_size;
  unsigned int num_dir_blocks = (from->size + block_size - 1) / block_size;
  
  // Obetenemos la longitud del nombre ya que el campo name/path de DirEntry no contiene '\0' entonces la coparacion fallaria
  unsigned int filename_length = strlen(filename);
  
  // Inicializamos el buffer para guardar bloques intermedios (recordar liberar)
  unsigned char *buffer = new unsigned char[block_size];
  
  // Mientras estemos en rango y no hallemos el resultado seguimos iterando
  for (unsigned int block_number = 0;
       block_number < num_dir_blocks && result == NULL; block_number++) {
    
    // Utilizamo `get_block_address` para obtener la direccion de memoria del i-esimo bloque de la entrada del directorio y lo cargamos en el buffer
    read_block(get_block_address(from, block_number), buffer);
    // Definimos el offset dentro del bloque a donde debemos acceder
    unsigned int offset_in_block = 0;
    
    // Mientras no hallemos el resultado y el offset sea menor al tamaño del bloque seguimos buscando
    while (offset_in_block < block_size && result == NULL) {
      //Con aritmetica de puntero obtenemos la entrada de directorio correspondiente casteandolo a struct Ext2FSDirEntry*
      struct Ext2FSDirEntry *dir_entry =
          (struct Ext2FSDirEntry *)(buffer + offset_in_block);

      // Si el record_length es 0 significa que ese bloque no esta asignado entonces los saltmos
      if (dir_entry->record_length == 0)
        break;
      

      // Si el inode es distinto de 0 significa que no esta Spare
      if (dir_entry->inode != 0) {

        // Comparamos la longitud el nombre y los caracteres hacemos ambos debido a que si no a == ab, si no usamos el length
        if (dir_entry->name_length == filename_length &&
            strncmp(filename, dir_entry->name, filename_length) == 0) {
          // En caso de ser el mismo rompemos el ciclo
          result = load_inode(dir_entry->inode);
          break;
        }
      }

      // Si no lo encontramos vamos al siguiente bloque aumentando el offset
      offset_in_block += dir_entry->record_length;
    }
  }


  // Borramos el buffer auxiliar para los bloques intermedios
  delete[] buffer;


  // Si empezamos desde el root debemos liberar el struct que inicializamos al comienzo
  if (from_is_root)
    free_inode(from);


  // Retornamos el inodo correspondiente
  return result;
}

fd_t Ext2FS::get_free_fd() {
  for (fd_t fd = 0; fd < EXT2_MAX_OPEN_FILES; fd++) {
    // Warning: This is inefficient
    if (!(_fd_status[fd / sizeof(unsigned int)] &
          (1 << (fd % sizeof(unsigned int)))))
      return fd;
  }
  return -1;
}

void Ext2FS::mark_fd_as_used(fd_t fd) {
  _fd_status[fd / sizeof(unsigned int)] |= (1 << (fd % sizeof(unsigned int)));
}

void Ext2FS::mark_fd_as_free(fd_t fd) {
  _fd_status[fd / sizeof(unsigned int)] ^= (1 << (fd % sizeof(unsigned int)));
}

fd_t Ext2FS::open(const char *path, const char *mode) {
  fd_t new_fd = get_free_fd();
  if (new_fd < 0)
    return -1;
  mark_fd_as_used(new_fd);

  // We ignore mode
  struct Ext2FSInode *inode = inode_for_path(path);
  if (inode == NULL) {
    mark_fd_as_free(new_fd);
    return -1;
  }

  _open_files[new_fd] = *inode;
  free_inode(inode);
  _seek_memory[new_fd] = 0;

  return new_fd;
}

int Ext2FS::read(fd_t filedesc, unsigned char *buffer, int size) {
  int realsize = ((_seek_memory[filedesc] + size) >= _open_files[filedesc].size)
                     ? _open_files[filedesc].size - _seek_memory[filedesc]
                     : size;
  if (realsize > 0) {
    int seek = _seek_memory[filedesc];
    int read = 0;

    // Compute block size by shifting the value 1024
    unsigned int block_size = 1024 << _superblock->log_block_size;

    unsigned int start_block = seek / block_size;
    unsigned int end_block = (seek + realsize - 1) / block_size;

    unsigned char *block_buf = new unsigned char[block_size];
    for (unsigned int block = start_block; block <= end_block; block++) {
      unsigned int block_address =
          get_block_address(&_open_files[filedesc], block);
      read_block(block_address, block_buf);

      do {
        buffer[read++] = block_buf[seek++ % block_size];
      } while (((seek % block_size) != 0) && (read < realsize));
    }
    delete[] block_buf;
  }
  return realsize;
}

int Ext2FS::write(fd_t filedesc, const unsigned char *buffer, int size) {
  return -1;
}

int Ext2FS::seek(fd_t filedesc, int offset) {
  int position = offset;
  if (offset < 0)
    position = _open_files[filedesc].size + offset;
  if (position >= (int)_open_files[filedesc].size)
    position = _open_files[filedesc].size - 1;
  _seek_memory[filedesc] = position;
  return position;
}

int Ext2FS::tell(fd_t filedesc) { return _seek_memory[filedesc]; }

void Ext2FS::close(fd_t filedesc) { mark_fd_as_free(filedesc); }
