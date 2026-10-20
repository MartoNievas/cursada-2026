# Seguridad de la información

**Sistemas Operativos — FCEyN, Universidad de Buenos Aires**

---

## 1. Seguridad de la información

La seguridad de la información consiste en preservar tres propiedades esenciales:

- **Confidencialidad:** solo los sujetos autorizados pueden acceder a la información.
- **Integridad:** se previenen o detectan modificaciones no autorizadas.
- **Disponibilidad:** la información y los servicios son accesibles cuando se los necesita.

Las principales amenazas a estas propiedades son:

- **Exposición de datos:** compromete la confidencialidad.
- **Manipulación de datos:** compromete la integridad.
- **Denegación de servicio (DoS):** compromete la disponibilidad.

> La seguridad de la información abarca personas, procesos y soportes físicos; la seguridad informática se enfoca puntualmente en proteger los sistemas computacionales que la procesan.

---

## 2. Los protagonistas

En el modelo de seguridad intervienen tres elementos fundamentales:

- **Sujetos:** entidades que realizan acciones (usuarios, procesos).
- **Objetos:** los recursos sobre los que se actúa (archivos, memoria, dispositivos, puertos).
- **Acciones:** las operaciones que un sujeto puede realizar sobre un objeto (leer, escribir, ejecutar, matar un proceso).

> **Nota:** Los roles de sujeto y objeto no son mutuamente excluyentes. Un caso clásico son los **procesos**, que actúan como sujetos al solicitar operaciones sobre archivos o memoria, y como objetos cuando otro proceso intenta enviarles señales o terminarlos.

La meta central es arbitrar qué sujetos pueden realizar qué acciones sobre qué objetos. Las abstracciones habituales para estructurar los sujetos son:

- **Usuario:** abstracción básica de sujeto en el sistema operativo; ejecuta acciones y puede ser propietario de objetos.
- **Grupo:** colección de usuarios que simplifica la asignación colectiva de permisos.
- **Rol:** abstracción funcional a la que se le asignan permisos; los usuarios adquieren privilegios en base a los roles que desempeñan (ej. operador, administrador).

---

## 3. Conceptos relacionados con la seguridad y autenticación

El modelo de control de acceso se apoya en la tríada **AAA**:

- **Authentication (autenticación):** mecanismo mediante el cual el sistema verifica si un sujeto realmente es quien dice ser.
- **Authorization (autorización):** determinación de las acciones y accesos permitidos para un sujeto ya autenticado.
- **Accounting / Auditoría:** registro cronológico e inalterable de las acciones que realizó cada sujeto en el sistema.

> Las funciones de autenticación y autorización deben mantenerse conceptual y funcionalmente desacopladas.

La autenticación se fundamenta tradicionalmente en tres factores generales: **algo que sé** (conocimiento), **algo que tengo** (posesión física) y **algo que soy** (características biométricas).

---

### 3.1 Autenticación mediante algo que sé (Contraseñas y secretos)

Es el método más extendido pero también el más vulnerable debido a patrones de comportamiento humano.

- **Vulnerabilidad de contraseñas débiles y ataques:**
  - *Ataques de diccionario y fuerza bruta:* Históricamente (Morris y Thompson, 1979), más del 86% de las contraseñas utilizadas coincidían con listas reducidas de nombres propios, calles, términos de diccionario o placas vehiculares. En filtraciones masivas modernas (como la de LinkedIn en 2012 con 6.4 millones de registros), las elecciones más frecuentes continúan siendo contraseñas triviales como `password` o `123456`.
  - *Reutilización y credenciales por defecto:* La proliferación de cuentas web fomenta que los usuarios elijan contraseñas cortas y las repitan en múltiples plataformas. Asimismo, dispositivos hogareños (routers, decodificadores) e instalaciones industriales (como las centrifugadoras atacadas por Stuxnet) suelen mantener las contraseñas de fábrica predeterminadas.
  - *Evolución de ataques remotos (War Dialing a Port Scanning):* El escaneo telefónico secuencial original evolucionó a scripts de red automatizados y herramientas avanzadas como `nmap`, capaces de mapear servicios expuestos (SSH, Telnet, Web) en bloques enteros de direcciones IP para lanzar pruebas masivas de credenciales.

- **Almacenamiento de contraseñas en UNIX / Linux:**
  - *Inseguridad del texto plano:* Almacenar contraseñas en claro en disco expone las credenciales a operadores, programadores o atacantes con acceso de lectura al archivo.
  - *Funciones unidireccionales de autenticación:* Al iniciar sesión, el programa `login` toma la contraseña provista y la pasa por una función unidireccional (*one-way function*), comparando la salida con el valor almacenado en el archivo del sistema. De este modo, nadie (ni siquiera el superusuario `root`) puede leer las contraseñas en claro.
  - *Ataques offline de precomputación:* Si un atacante accede al archivo con los hashes, puede calcular previamente los hashes de un diccionario completo y compararlos en fracciones de segundo.
  - *El uso de Salt:* Morris y Thompson introdujeron el concepto de asociar a cada contraseña un número pseudoaleatorio de $n$ bits no secreto denominado **salt**, que se modifica cada vez que el usuario cambia su clave. El salt se concatena a la contraseña antes de aplicar la función unidireccional:
    $$\text{almacenado} = (\text{login}, \text{salt}, f(\text{contraseña} \,\Vert{}\, \text{salt}))$$
    En UNIX clásico se fijó $n = 12$ bits. Esto obliga al atacante a precomputar $2^{12} = 4096$ hashes para cada palabra de su diccionario, incrementando el espacio de cómputo y el tamaño del archivo en un factor de 4096.
  - *Separación en Shadow Passwords:* En los sistemas modernos, los metadatos de las cuentas permanecen en `/etc/passwd` (legible por todos), pero los hashes con salt se trasladan a `/etc/shadow`, accesible únicamente con privilegios de `root`.
  - *Funciones modernas de derivación de claves:* Los hashes criptográficos rápidos diseñados para integridad (como SHA-256 directo) resultan inseguros para contraseñas, ya que facilitan ataques masivos de billones de intentos por segundo mediante GPU y ASIC. Se deben emplear funciones deliberadamente lentas y costosas en memoria: **Argon2id**, **scrypt**, **bcrypt** o **PBKDF2**.

- **Contraseñas de un solo uso (One-Time Passwords - OTP):**
  - Exigir una contraseña distinta para cada inicio de sesión neutraliza la utilidad de una clave capturada en tránsito.
  - *Esquema de cadenas de hash de Leslie Lamport (1981):* Permite autenticación segura sobre redes inseguras sin requerir almacenamiento de secretos en disco por parte del servidor ni del cliente.
    - Se basa en una función unidireccional $f$ donde calcular $y = f(x)$ es directo, pero obtener $x$ a partir de $y$ es inviable.
    - El usuario memoriza un secreto inicial $s$ y define un total de $n$ contraseñas posibles.
    - La primera contraseña a usar ($P_1$) se obtiene aplicando la función $n$ veces: $P_1 = f^n(s)$. La segunda contraseña aplica la función $n-1$ veces ($P_2 = f^{n-1}(s)$), y en general:
      $$P_i = f^{n-i+1}(s) \quad \text{cumpliéndose que} \quad P_{i-1} = f(P_i)$$
    - El servidor se inicializa con el valor base $P_0 = f(P_1)$ asociado al contador $i=1$.
    - Para la sesión $i$, el servidor solicita la contraseña $i$; el usuario envía $P_i$. El servidor calcula $f(P_i)$ y comprueba si coincide con el registro actual ($P_{i-1}$). Si coincide, acepta la sesión, incrementa el contador a $i+1$ y sobreescribe el registro anterior con $P_i$.
    - Un interceptor que capture la contraseña $P_i$ en tránsito solo podría deducir $P_{i-1}$ (ya consumida e inútil), pero le resulta computacionalmente imposible calcular $P_{i+1}$. Al agotarse las $n$ iteraciones, se reinicializa el esquema con un nuevo secreto.

- **Autenticación Desafío-Respuesta (Challenge-Response):**
  - Diseñada para evitar el reenvío de credenciales estáticas y mitigar ataques de repetición (*replay attacks*).
  - *Mecanismo básico:* El servidor emite un valor aleatorio y único temporal (*desafío* o *nonce*, $r$). El cliente procesa dicho valor mediante un algoritmo acordado o una clave secreta compartida $k$, generando una respuesta $f(r, k)$ que envía al servidor. El servidor computa idéntica operación y autoriza si los resultados coinciden.
  - Al cambiar $r$ en cada sesión, un atacante que escuche y registre el tráfico no obtiene información útil para autenticarse en accesos posteriores.

---

### 3.2 Autenticación mediante algo que tengo (Objetos físicos)

Comprueba la posesión de un elemento tangible. Para evitar el uso indebido por extravío o robo, suele combinarse con un factor de conocimiento (PIN o contraseña), dando lugar a esquemas multifactor.

- **Tarjetas de banda magnética:**
  - Almacenan aproximadamente 140 bytes en una cinta magnética adherida al reverso.
  - Suelen incluir el PIN cifrado para permitir validación en terminales desconectadas.
  - *Riesgo:* Elevada inseguridad; el equipamiento para leer, clonar y reescribir bandas magnéticas es económico y de fácil acceso (*skimming*).
- **Tarjetas con chip de valor almacenado (*Stored Value Cards*):**
  - Integran una pequeña memoria ROM no volátil (pocos kilobytes) sin procesador central (CPU).
  - El saldo o valor lo decrementa directamente el lector externo (tarjetas prepagas de telefonía o transporte).
  - Carecen de capacidad de cómputo autónomo para participar en protocolos criptográficos avanzados.
- **Tarjetas inteligentes (*Smart Cards*):**
  - Computadoras miniaturizadas a prueba de manipulaciones físicas (*tamper-proof*), provistas de procesador propio y memoria segura.
  - Son capaces de interactuar en protocolos criptográficos bidireccionales con un servidor central sin exponer sus secretos internos.
  - *Protocolo de autenticación en Smart Cards:* El servidor emite un número aleatorio de longitud fija (ej. 1024 bits); el chip de la tarjeta lo procesa internamente combinándolo con su clave privada o secreto almacenado mediante un algoritmo criptográfico y retorna el resultado. El canal puede ser interceptado sin que el atacante descubra la clave del chip ni pueda reutilizar la respuesta.
- **Tokens modernos y FIDO2 / WebAuthn:**
  - Dispositivos de hardware criptográfico (como llaves de seguridad USB/NFC) que generan firmas asimétricas vinculadas criptográficamente al dominio del sitio web (*origin-bound*), neutralizando de forma nativa los ataques de phishing y Man-in-the-Middle.

---

### 3.3 Autenticación mediante algo que soy (Biometría)

Mide rasgos biológicos, fisiológicos o conductuales del individuo que resultan difíciles de falsificar (huellas dactilares, iris, geometría facial, reconocimiento de voz).

- **Fases del sistema biométrico:**
  1. **Enrolamiento (*Enrollment*):** Se efectúa la lectura inicial del rasgo físico, se digitaliza y se extraen sus características estadísticas salientes, guardándolas como una plantilla (*template*) de referencia en una base de datos segura o dentro de un chip físico personal.
  2. **Identificación / Verificación:** El usuario presenta su identidad reclamada (login name) y se efectúa una nueva medición física. Se requiere el nombre de usuario debido a que las muestras biométricas son analógicas, contienen ruido y nunca coinciden bit a bit; esto impide indexar las muestras como si fuesen claves exactas y exige contrastar la lectura contra un perfil específico.
- **Requisitos de los rasgos elegidos:**
  - *Variabilidad / Entropía:* El rasgo debe poseer suficiente diversidad intrínseca para distinguir de forma unívoca a un individuo frente a poblaciones masivas (rasgos como el color de cabello carecen de variabilidad suficiente).
  - *Invarianza temporal:* El patrón no debe alterarse de forma sustancial con el paso del tiempo, el envejecimiento o contingencias menores (una afonía temporal afecta la voz; barba o maquillaje pueden dificultar el reconocimiento facial).
- **Métricas de error y decisiones de diseño:**
  - Como las lecturas jamás son idénticas a la plantilla original, el sistema trabaja con umbrales de coincidencia probabilística, enfrentando dos tipos de fallas:
    - **Falsa Aceptación (FAR - False Acceptance Rate):** El sistema confunde a un impostor y le permite el acceso.
    - **Falso Rechazo (FRR - False Rejection Rate):** El sistema no reconoce a un usuario legítimo y lo bloquea.
  - La calibración del umbral depende estrictamente del contexto operativo: un sitio de comercio electrónico prefiere asumir una tasa baja de fraude antes que rechazar sistemáticamente a clientes genuinos (prioriza bajo FRR); una instalación militar de armamento priorizará un FAR cercano a cero, asumiendo la molestia de rechazar temporalmente a personal autorizado.
- **Aceptabilidad psicológica:**
  - La técnica debe ser aceptada social y operativamente por los usuarios para ser viable. Métodos percibidos como invasivos o estigmatizantes (como asociar la toma de huellas con antecedentes penales) generan resistencia cultural, mientras que su uso en dispositivos personales de bolsillo resulta ampliamente aceptado.

---

### 3.4 Resumen de factores y Autenticación Multifactor (MFA)

| Tipo de Factor | Categoría | Ejemplos | Ventajas | Vulnerabilidades Principales |
| :--- | :--- | :--- | :--- | :--- |
| **Algo que sé** | Conocimiento | Contraseñas, PINs, respuestas a preguntas secretas | Económico, sin hardware adicional | Fuerza bruta, phishing, filtraciones de hashes, reutilización |
| **Algo que tengo** | Posesión | Tarjetas con chip, Smart Cards, llaves FIDO2, OTPs | Resistente a ataques remotos puros | Extravío físico, robo, costos de aprovisionamiento |
| **Algo que soy** | Inherencia | Huellas dactilares, reconocimiento facial, iris | No se puede olvidar ni transferir fácilmente | Ruidoso en la medición (FAR/FRR), imposible de renovar tras un compromiso |

> **Principio de MFA:** Para que un esquema sea genuinamente multifactor, debe exigir la combinación concurrente de **al menos dos categorías distintas** (por ejemplo, posesión de tarjeta inteligente + conocimiento de PIN). Solicitar dos contraseñas distintas o una contraseña junto a una pregunta secreta corresponde a dos mecanismos de la misma categoría (*conocimiento*) y no constituye autenticación de múltiples factores.

---

## 4. Criptografía

La criptografía aporta las herramientas matemáticas para garantizar confidencialidad, integridad, autenticación y no repudio. En los sistemas operativos se aplica en diversos componentes: desde el cifrado transparente de archivos en disco hasta protocolos de red como IPsec, TLS o SSH.

El objetivo básico consiste en tomar un mensaje o archivo legible, denominado **texto plano** (*plaintext*, $P$), y transformarlo mediante un algoritmo de cifrado en un texto ininteligible, denominado **texto cifrado** (*ciphertext*, $C$), de modo que solo las entidades autorizadas puedan revertirlo al contenido original.

- **Principio de Kerckhoffs y formalización matemática:** La seguridad de un esquema criptográfico nunca debe depender del secreto del algoritmo empleado (evitar la *seguridad por oscuridad*). Los algoritmos de cifrado y descifrado deben ser públicos y abiertos al escrutinio; toda la confidencialidad debe residir exclusivamente en la protección de parámetros denominados **claves**.
  - Cifrado: $C = E(P, K_E)$, donde $E$ es la función pública de cifrado y $K_E$ es la clave de cifrado.
  - Descifrado: $P = D(C, K_D)$, donde $D$ es la función pública de descifrado y $K_D$ es la clave de descifrado correspondiente.

### Familias criptográficas principales

- **Cifrado simétrico (clave secreta):** La clave de descifrado es idéntica a la clave de cifrado ($K_E = K_D$) o puede derivarse directamente a partir de ella.
  - *Ejemplo conceptual:* La sustitución monoalfabética asigna a cada letra del alfabeto una letra fija de reemplazo (como mapear `A...Z` a `QWERTY...`). Aunque trivial de quebrar por análisis de frecuencias, ilustra la simetría: conocida la tabla para cifrar, la de descifrado se deduce de forma inmediata.
  - *Seguridad:* En algoritmos modernos robustos (**AES**, **ChaCha20**), la seguridad depende del tamaño de la clave. Un estándar seguro utiliza claves de al menos 256 bits, lo que genera un espacio de búsqueda de $2^{256} \approx 1.15 \times 10^{77}$ combinaciones posibles, haciendo inviable un ataque por fuerza bruta.
  - *Ventaja y desventaja:* Ofrece una altísima eficiencia computacional, pero presenta el problema de distribución de claves: emisor y receptor deben compartir previamente el secreto por un canal seguro.
- **Cifrado asimétrico (clave pública):** Desacopla el proceso mediante un par de claves matemáticamente enlazadas: una **clave pública** ($K_E$, accesible para cualquier emisor) y una **clave privada** ($K_D$, resguardada exclusivamente por el receptor).
  - *Asimetría computacional:* Se basa en funciones trampa de un solo sentido (*trapdoor functions*), donde una operación es directa de calcular pero su inversa es computacionalmente intratable sin información privilegiada. En **RSA**, multiplicar dos primos grandes bajo aritmética modular es inmediato, mientras que factorizar un producto compuesto $n = p \cdot q$ de cientos de dígitos resulta inviable en tiempo razonable.
  - *Confidencialidad:* Todo mensaje destinado al receptor se cifra con la clave pública de este; únicamente su clave privada puede descifrarlo.
  - *Compromiso operativo:* Elimina la necesidad de transmitir claves secretas compartidas, pero es aproximadamente tres órdenes de magnitud (1000 veces) más lento que el cifrado simétrico. Por ello, se utiliza comúnmente en esquemas híbridos donde protege una clave simétrica temporal de sesión, la cual cifra el flujo de datos.
- **Hash criptográfico:** Función matemática unidireccional que procesa una entrada de longitud arbitraria y genera una salida (*digest*) de **longitud fija** (ej. SHA-256 genera 32 bytes y SHA-512 genera 64 bytes). No utiliza claves ni permite descifrado.

> **Cifrados históricos e inseguros:** Algoritmos como **Caesar** y **DES** son obsoletos y vulnerables. En funciones de hash, **MD5** y **SHA-1** están rotos y no deben usarse bajo ningún escenario que exija resistencia a colisiones.

El cifrado por sí solo no garantiza integridad: un atacante podría alterar los bits del mensaje cifrado en tránsito sin conocer la clave. Para garantizar confidencialidad e integridad simultáneas se emplean esquemas de **cifrado autenticado** (como **AES-GCM**) o códigos de autenticación de mensajes.

### 4.1 Funciones de hash para uso en seguridad

Una función de hash criptográfica $H$ debe satisfacer tres propiedades formales:

- **Resistencia a preimagen:** dado un valor de resumen $h$, debe ser computacionalmente inviable hallar un mensaje $m$ tal que $H(m) = h$.
- **Resistencia a segunda preimagen:** dado un mensaje específico $m_1$, debe ser computacionalmente inviable hallar otro mensaje $m_2 \neq m_1$ tal que $H(m_1) = H(m_2)$.
- **Resistencia a colisiones:** debe ser computacionalmente inviable encontrar cualquier par de mensajes distintos $m_1 \neq m_2$ tales que $H(m_1) = H(m_2)$.

Un estándar seguro y extendido es **SHA-256**. Un hash sin clave no autentica el origen (un atacante podría reemplazar simultáneamente el mensaje y el hash en tránsito); para autenticar datos se emplean esquemas **MAC** (como **HMAC**) o firmas digitales.

### 4.2 Autenticación y contraseñas

- **Almacenamiento seguro:** Las contraseñas nunca deben guardarse en texto plano ni mediante cifrado reversible. Se almacena un derivado calculado con funciones lentas y diseñadas específicamente para resistir ataques offline de fuerza bruta por GPU o ASIC: **Argon2id**, **scrypt**, **bcrypt** o **PBKDF2**. No se debe usar un hash criptográfico rápido como SHA-256 de forma directa.
- **Salt:** Valor pseudoaleatorio y único por usuario que se almacena junto al derivado; **no es secreto**. Su propósito es evitar que dos contraseñas idénticas generen el mismo hash y neutralizar ataques con tablas precalculadas (*rainbow tables*).
- **Implementación en Linux:** Los metadatos de las cuentas residen en `/etc/passwd` (legible por todos), mientras que los hashes derivados protegidos se ubican en `/etc/shadow` (con permisos de acceso estrictamente restringidos al administrador).

### 4.3 Factores de autenticación y protocolos remotos

- **MFA (Multi-Factor Authentication):** Requiere combinar factores de categorías disjuntas:
  - *Algo que sé* (contraseña, PIN).
  - *Algo que tengo* (token de hardware, llave FIDO2).
  - *Algo que soy* (biometría).
  
  Dos contraseñas distintas pertenecen a la misma categoría y no constituyen MFA.
- **Autenticación con claves públicas (SSH):**
  - Demuestra la posesión de una clave privada sin transmitirla por el canal de comunicación.
  - El servidor mantiene registrada la clave pública autorizada del usuario (ej. en `~/.ssh/authorized_keys`).
  - Durante el handshake, el cliente firma un desafío vinculado a la sesión con su clave privada y el servidor verifica dicha firma con la clave pública.
  - El cliente debe verificar la identidad del servidor mediante la clave de host (*host key*); aceptar claves de host no verificadas expone la sesión a ataques de intermediario (*Man-in-the-Middle*).
- **Ataques de replay:** Transmitir hashes por un canal sin cifrar permite que un atacante capture y reutilice el hash. Se mitigan mediante esquemas de **desafío-respuesta (*Challenge-Response*)** con valores únicos temporales (*nonces*) o cifrando el canal completo (TLS).

### 4.4 Algoritmo RSA y firmas digitales

- **Generación de claves:**
  1. Se eligen dos primos grandes $p \neq q$ y se calcula el módulo $n = p \cdot q$.
  2. Se calcula $\varphi(n) = (p-1)(q-1)$.
  3. Se elige un exponente público $e$ tal que $1 < e < \varphi(n)$ y $\gcd(e, \varphi(n)) = 1$.
  4. Se calcula el exponente privado $d$ como el inverso multiplicativo modular: $e \cdot d \equiv 1 \pmod{\varphi(n)}$.
  
  - **Clave pública:** $(n, e)$.
  - **Clave privada:** $(n, d)$, manteniendo en secreto $p$ y $q$.
- **Cifrado y descifrado:**
  - Cifrado: $c \equiv m^e \pmod n$.
  - Descifrado: $m \equiv c^d \pmod n$.
  
  La seguridad radica en la dificultad computacional de factorizar el módulo $n$ para recuperar $p$ y $q$. En la práctica se requiere un tamaño mínimo de módulo de 2048 bits junto con esquemas de relleno seguros (*padding*).
- **Firma digital y no repudio:**
  - *Propiedad matemática:* Aprovecha que en sistemas como RSA las operaciones son inversas respecto a las claves pública y privada: $E(D(x)) = x$.
  - *Procedimiento:*
    1. El emisor calcula el hash criptográfico del documento.
    2. Cifra el hash resultante con su **clave privada** (bloque de firma) y lo adjunta al documento original.
    3. El receptor descifra la firma utilizando la **clave pública del emisor** y compara el valor resultante con el hash que él mismo calcula sobre el documento recibido.
  - *Garantías:* Asegura integridad (el documento no fue alterado) y autenticidad/no repudio (solo el poseedor de la clave privada pudo generarlo). Aplicar la clave asimétrica únicamente sobre el hash optimiza el rendimiento frente a la lentitud del cifrado asimétrico.
- **Certificados y TLS:** Un certificado digital vincula una identidad con una clave pública mediante la firma de una Autoridad Certificante (CA). La validación exige verificar la cadena de confianza, fechas de vigencia y estado de revocación.

### 4.5 Criptografía post-cuántica (PQC)

- El **algoritmo de Shor** resuelve eficientemente el problema de factorización de enteros y logaritmos discretos, quebrando algoritmos asimétricos clásicos como RSA, Diffie-Hellman y ECC una vez que existan computadoras cuánticas a escala. No afecta de la misma forma al cifrado simétrico (AES) ni a las funciones de hash.
- **Amenaza *Harvest now, decrypt later*:** Adversarios capturan y almacenan hoy tráfico cifrado clásico para descifrarlo a futuro cuando dispongan de capacidad cuántica suficiente.
- **Estándares del NIST:**
  - FIPS 203 (ML-KEM / Kyber): encapsulación de claves.
  - FIPS 204 (ML-DSA / Dilithium): firmas digitales.
  - FIPS 205 (SLH-DSA / SPHINCS+): firmas basadas en hashes.

---

## 5. Autorización y control de acceso en sistemas operativos

### 5.1 Monitor de referencias y representación de permisos

- **Monitor de referencias:** Componente del núcleo encargado de validar cada solicitud de un sujeto sobre un objeto contrastándola contra la política de seguridad. Requiere cumplir tres propiedades de diseño:
  - **Mediación completa:** Intercepta absolutamente todas las operaciones de acceso relevantes.
  - **A prueba de manipulaciones:** Es resistente a modificaciones no autorizadas.
  - **Verificable:** Su diseño e implementación son lo suficientemente compactos como para ser auditados formalmente.
- **Matriz de control de acceso:** Abstracción bidimensional donde las filas representan sujetos (o dominios de protección), las columnas representan objetos y las celdas contienen el conjunto de permisos autorizados.
  - En la práctica, almacenar la matriz completa en disco casi nunca se implementa porque es una estructura sumamente grande y dispersa (*sparse*); la gran mayoría de los dominios no tienen acceso alguno a la mayoría de los objetos, por lo que guardar una matriz vacía desperdiciaría espacio masivo.
  - Las soluciones viables almacenan únicamente los elementos no vacíos descomponiendo la matriz:
    - **Por columnas (ACLs - Access Control Lists):** Se asocia a cada objeto una lista con los sujetos y sus respectivos derechos de acceso.
    - **Por filas (Capacidades - Capabilities):** Se asocia a cada sujeto/proceso una lista con los objetos sobre los cuales posee derechos y permisos.
  - **Principio general:** Denegación por defecto (*fail-safe defaults*), donde todo acceso no explícitamente concedido en la lista está terminantemente prohibido, y principio de mínimo privilegio.

### 5.2 Listas de control de acceso (ACLs)

Una ACL es una lista (generalmente ordenada) vinculada directamente a un objeto que especifica qué dominios o sujetos tienen permitido interactuar con él y de qué manera.

- **Alcance por sujeto (Dueño vs. Proceso):**
  - Los permisos se conceden por usuario/sujeto y no por proceso individual.
  - Si un usuario tiene asignados derechos sobre un archivo, cualquier proceso ejecutado por dicho usuario heredará esos privilegios, sin importar si existe un único proceso o cientos de ellos corriendo en simultáneo. Lo que evalúa el sistema es la identidad del dueño (*principal/subject*), no el identificador de proceso (PID).
- **Tipos de derechos de acceso:**
  - *Genéricos:* Aplican a cualquier tipo de objeto en el sistema (ej. leer `R`, escribir `W`, ejecutar `X`, destruir objeto o copiar objeto).
  - *Específicos del objeto:* Aplican exclusivamente a la semántica particular del recurso (ej. anexar mensajes en un buzón de correo, u ordenar alfabéticamente las entradas de un directorio).
- **Semántica de grupos y roles en ACLs:**
  - *Modelo por pares (UID, GID):* Las entradas tienen el formato `UID, GID: permisos`. Para que un proceso acceda, debe coincidir tanto su usuario como su grupo actual. Esto formaliza el concepto de **roles**: un usuario con privilegios administrativos (`sysadm`) que además pertenece a un grupo recreativo (`club`) debe elegir bajo qué rol inicia sesión; esto impide que realice tareas de administración mientras opera bajo su perfil recreativo, reduciendo el riesgo de accidentes o canales encubiertos.
  - *Comodines (Wildcards) y listas de bloqueo explícito:*
    - Se puede usar un comodín `*` para indicar que un derecho aplica a todos los grupos de un usuario (ej. `tana, *: RW`) o a todos los usuarios del sistema (`*, *: RW`).
    - Las ACLs suelen evaluarse en **orden secuencial** estricto: la primera regla que coincide con la solicitud es la que se aplica y la búsqueda termina de inmediato.
    - Gracias a esto, es posible bloquear selectivamente a un sujeto particular antes de otorgar acceso universal:
```text
      anna, *: (none);
      *, *: RW;
```
      En este caso, la búsqueda encuentra primero la regla de *Anna*, deniega todo acceso y aborta la inspección, impidiendo que alcance la regla general posterior.
  - *Modelo disyuntivo (UID o GID):* Cada entrada de la lista contiene un usuario o un grupo de forma aislada (ej. `debbie: RW; staff: RW;`). Si el usuario pertenece a cualquiera de los grupos autorizados, el acceso es concedido de manera acumulativa sin necesidad de seleccionar un rol al autenticarse.
- **Revocación de permisos:**
  - Con ACLs, revocar un permiso es directo: basta con editar o eliminar la entrada correspondiente en la lista del objeto.
  - *Problema de revocación diferida:* En la mayoría de los sistemas operativos, las comprobaciones de la ACL se realizan únicamente durante la llamada al sistema de apertura (`open`). Si un usuario ya tiene un descriptor de archivo abierto y el administrador le revoca el acceso en la ACL, el proceso conservará sus derechos hasta que cierre el archivo, postergando la aplicación efectiva del cambio hasta futuras llamadas al sistema.
- **Administración en sistemas operativos modernos:**
  - **Linux / FreeBSD (POSIX ACLs):** Utilizan `getfacl` para inspeccionar y `setfacl` para modificar listas granulares (ej. `setfacl -m u:usuario:rw archivo.txt` otorga acceso directo a un usuario sin obligar a cambiar los permisos tradicionales de grupo ni hacer el archivo público).
  - **Windows (NTFS):** Permite inspeccionar y alterar las listas de control mediante PowerShell con los cmdlets `Get-Acl` y `Set-Acl`.
  - **macOS:** Soporta ACLs avanzadas integrándolas directamente dentro del comando `chmod`.

### 5.3 Listas de capacidades (C-Lists)

Consiste en dividir la matriz de control de acceso por filas. A cada proceso (o dominio de seguridad) se le asocia una lista de objetos que puede acceder junto con las operaciones permitidas sobre cada uno. La lista se denomina **C-list** (*capability list*) y cada entrada es un ticket infalsificable denominado **capacidad** (*capability*).

- **Estructura y derechos:**
  - Una capacidad se compone típicamente de un **identificador de objeto** (ej. número de i-nodo en sistemas tipo UNIX) y un **mapa de bits de derechos** (*rights bitmap*).
  - Las C-lists son objetos en sí mismas y pueden ser referenciadas desde otras C-lists, lo que facilita compartir subdominios de seguridad.
  - *Derechos genéricos comunes:*
    1. *Copy capability:* crear una nueva capacidad para el mismo objeto.
    2. *Copy object:* crear un duplicado del objeto con una nueva capacidad asociada.
    3. *Remove capability:* borrar una entrada de la C-list (sin destruir el objeto).
    4. *Destroy object:* eliminar permanentemente el objeto físico y la capacidad.

- **Protección contra manipulaciones del usuario:**
  Dado que una capacidad otorga acceso directo por su mera posesión, el usuario no debe poder alterarla ni falsificarla. Existen tres mecanismos para resguardarlas:
  1. **Arquitectura etiquetada (*Tagged Architecture*):** El hardware incluye un bit de etiqueta (*tag bit*) por cada palabra de memoria que indica si contiene una capacidad o datos comunes. El bit de etiqueta solo puede ser modificado por instrucciones ejecutadas en modo kernel (ej. IBM AS/400).
  2. **Gestión dentro del kernel:** El sistema operativo retiene la C-list en espacio de núcleo (ej. sistema Hydra). El proceso usuario únicamente hace referencia a las capacidades mediante índices numéricos (similar a los descriptores de archivo en UNIX: *"leer del archivo apuntado por la capacidad 2"*).
  3. **Protección criptográfica en espacio de usuario:** Las C-lists residen en el espacio de usuario, pero cada capacidad está protegida criptográficamente mediante una función unidireccional (diseñado para sistemas distribuidos como Amoeba).
     - Al crear un objeto, el servidor genera un número pseudoaleatorio largo llamado campo de verificación (**check field**) y lo guarda en su tabla interna privada (análogo al i-nodo).
     - La capacidad entregada al cliente contiene: `[ID Servidor | N° Objeto | Derechos | f(Objeto, Derechos, Check)]`, donde $f$ es una función hash o resumen criptográfico unidireccional.
     - Al enviar una solicitud, el cliente adjunta la capacidad. El servidor busca el objeto, recupera su *check field* privado y recomputa $f$. Si el valor coincide con el de la capacidad, la operación se aprueba; si el usuario intentó forjarla o activar bits de permisos apagados, la verificación falla.
     - Para delegar privilegios reducidos (ej. solo lectura), el servidor calcula una nueva capacidad utilizando los derechos reducidos pero conservando el mismo *check field* original.

- **El problema de la revocación en sistemas de capacidades:**
  - Revocar accesos es intrínsecamente complejo: las capacidades pueden estar dispersas en múltiples C-lists o copiadas por procesos en memoria y disco sin que el sistema mantenga un registro centralizado de quiénes las poseen.
  - *Revocación por indirección:* Cada capacidad apunta a un objeto indirecto intermedio, el cual apunta al objeto real. Para revocar, el sistema rompe el enlace intermedio haciendo que apunte a `null`.
  - *Revocación en esquemas criptográficos (Amoeba):* Basta con que el servidor cambie el *check field* guardado junto al objeto en disco; instantáneamente todas las capacidades existentes en circulación quedan invalidadas.
  - *Defecto inherente:* No permiten **revocación selectiva** fácilmente (ej. revocarle el acceso a un usuario específico sin invalidar las capacidades de los demás legítimos poseedores). Tampoco impiden que un poseedor legítimo comparta libremente una copia de su capacidad con otros procesos sin control del kernel.

### 5.4 Comparación: ACLs vs. Capacidades

| Característica | Listas de Control de Acceso (ACLs) | Capacidades (Capabilities) |
| :--- | :--- | :--- |
| **Organización de la matriz** | Por columnas (asociada al objeto) | Por filas (asociada al sujeto/proceso) |
| **Eficiencia de acceso** | Requiere una búsqueda secuencial en la lista por cada acceso | Muy rápida e inmediata (acceso directo por índice/ticket) |
| **Revocación de derechos** | Sencilla y selectiva por usuario | Difícil globalmente; casi inviable de forma selectiva |
| **Encapsulación de procesos** | Compleja de restringir a nivel de proceso aislado | Natural y sencilla (el proceso solo ve lo que tiene en su C-list) |
| **Consistencia al borrar objetos** | Si el objeto se borra, su ACL se destruye con él | Si un objeto se borra, pueden quedar capacidades huérfanas activas |

> **Aclaración terminológica:** Sistemas como el microkernel **L4** o **Capsicum** en FreeBSD implementan modelos puros de capacidades orientados a objetos. Las llamadas **Linux Capabilities** (`CAP_NET_BIND_SERVICE`, `CAP_SYS_ADMIN`, etc.) dividen las facultades de administración de `root` en el kernel, pero no constituyen capacidades puras en el sentido formal de la literatura de seguridad de sistemas operativos.

### 5.5 Modelos de acceso: DAC vs. MAC

- **DAC (Discretionary Access Control):** El propietario del objeto decide qué permisos otorga o revoca a otros usuarios dentro del marco de reglas del sistema.
- **MAC (Mandatory Access Control):** Las políticas de acceso son globales y definidas de forma centralizada por el administrador o el sistema; el propietario no puede eludirlas modificando permisos DAC. DAC y MAC suelen coexistir: si una operación es permitida por DAC pero rechazada por MAC, el acceso es denegado.
- **RBAC (Role-Based Access Control):** Los permisos se asocian a roles funcionales y los usuarios adquieren permisos según los roles que tienen asignados.

### 5.6 Control de accesos en UNIX / Linux

El esquema tradicional de permisos en UNIX consta de 3 grupos de 3 bits (`rwx` para propietario, grupo y otros) más un bit que describe el tipo de archivo. La creación de archivos aplica una máscara de permisos (*umask*).

- **Bits especiales:**
  - **SETUID:** En un binario ejecutable, hace que el proceso corra temporalmente con el UID efectivo (`euid`) del dueño del archivo y no con el del usuario que lo invoca (ej. `/usr/bin/passwd` para modificar `/etc/shadow`).
  - **SETGID:** En ejecutables fija el `egid` al del grupo del archivo. En directorios, provoca que los archivos y subdirectorios nuevos hereden automáticamente el grupo del directorio padre.
  - **Sticky bit:** En directorios compartidos (como `/tmp`), impide que un usuario borre o renombre un archivo a menos que sea el dueño del archivo, el dueño del directorio o `root`.
- **Mecanismos avanzados:**
  - **Linux Capabilities:** Descompone el privilegio total de `root` en capacidades acotadas para evitar binarios con privilegios excesivos (ej. `CAP_NET_BIND_SERVICE` para escuchar en puertos $<1024$, `CAP_NET_RAW` para paquetes crudos ICMP en `ping`, `CAP_SETUID`, `CAP_SYS_ADMIN`).
  - **SUDO (Super User Do):** Ejecuta comandos como otro usuario según una política granular. Registra invocaciones en un log; capturar entrada/salida requiere configuración adicional. La política puede ser local o centralizada; revocarla no termina procesos ya iniciados. Permite acotar comandos y argumentos posibles, usando rutas seguras y mínimo privilegio.
  - **Atributos de sistema de archivos:** Comandos `chattr` / `lsattr` para banderas como inmutabilidad (`+i`) o solo agregado (`+a`).

### 5.7 Modelos en Windows

- **DACLs en NTFS:** Cada objeto posee una Discretionary Access Control List compuesta por ACEs (*Access Control Entries*) que definen permisos concedidos o denegados a tokens de seguridad.
- **MIC (Mandatory Integrity Control):** Capa MAC basada en el modelo formal Biba de integridad. Asigna niveles de integridad a procesos y objetos (*Low*, *Medium*, *High*, *System*). Aplica la regla estricta de **no write-up**: un proceso con un nivel de integridad inferior no puede escribir ni modificar recursos de un nivel superior, independientemente de lo permisiva que sea la DACL.

---

## 6. Seguridad en el software y vulnerabilidades

### 6.1 Vulnerabilidades de memoria: Buffer Overflow

- **Mecanismo en stack:** Ocurre al escribir más datos de los reservados en un búfer local sin validar longitudes (ej. con funciones no seguras como `strcpy` o `gets`). Los datos excedentes sobreescriben variables locales, el frame pointer y la dirección de retorno (*Instruction Pointer*, IP) guardada en la pila de llamadas, desviando el flujo de ejecución hacia código malicioso inyectado (*shellcode*).
- **Variantes:** Stack-based (en la pila) y heap-based (en memoria dinámica).
- **Mitigaciones del sistema operativo y compilador:**
  - **ASLR (Address Space Layout Randomization):** Aleatoriza las direcciones base de memoria (stack, heap, bibliotecas) en cada ejecución para dificultar el salto a direcciones predecibles.
  - **NX / DEP (No-Execute / Data Execution Prevention):** Marca las páginas de datos (pila y heap) como no ejecutables mediante soporte de hardware.
  - **Stack Canaries:** Valores testigo insertados por el compilador entre las variables locales y la dirección de retorno; si el valor cambia antes de ejecutar el retorno de la función (`ret`), el proceso aborta inmediatamente.

### 6.2 Inyecciones y validación de parámetros

- **Inyección de comandos y SQL Injection:** Se producen cuando se concatenan directamente entradas externas sin sanitizar dentro de comandos del intérprete del sistema o consultas de bases de datos.
- **Defensas:**
  - Aplicar el principio de **tainted data**: tratar toda entrada externa (argumentos, variables de entorno, sockets de red) como no confiable por defecto.
  - Validar y sanitizar parámetros antes de procesarlos.
  - Utilizar consultas parametrizadas o sentencias preparadas en bases de datos.
  - Ejecutar los procesos con el mínimo privilegio posible para limitar el impacto en caso de explotación.

### 6.3 Condiciones de carrera: TOCTOU

- **Time of Check to Time of Use (TOCTOU):** Ocurre cuando un programa comprueba el estado de un recurso (ej. verificar si un archivo existe) y luego opera sobre él (ej. crearlo o escribirlo), existiendo una ventana temporal donde un atacante concurrente puede alterar la ruta mediante enlaces simbólicos (*symlinks*).
- **Solución:** Hacer la operación **atómica** (indivisible) a nivel del kernel y del sistema de archivos, utilizando flags de creación exclusiva como `open("/tmp/archivo", O_WRONLY | O_CREAT | O_EXCL, 0600)` o APIs dedicadas como `mkstemp`.

---

## 7. Malware, aislamiento y técnicas de ataque

### 7.1 Tipos de malware y vectores

- **Malware (*Malicious Software*):** Software diseñado para ejecutar acciones no deseadas sin el consentimiento explícito del usuario.
- **Variantes:** Virus, gusanos (capacidad de autorreplicación autónoma en red), troyanos, rootkits (ocultan la presencia de procesos y archivos a nivel de kernel), ransomware, bots y keyloggers.
- **Vectores de infección:** Descargas web involuntarias, adjuntos por correo, vulnerabilidades en software no actualizado y medios de almacenamiento extraíbles.
- **Etapas de un ataque avanzado:** Denegación de servicio (DoS), escalamiento de privilegios (de usuario sin privilegios a administrador/root), movimiento lateral dentro de la red, persistencia frente a reinicios y exfiltración de información confidencial.

### 7.2 Técnicas de aislamiento

- **`chroot()`:** Cambia el directorio raíz visible (`/`) para el proceso actual, pero por sí solo no representa una frontera de seguridad completa ni aísla la tabla de procesos ni la red.
- **Contenedores (Namespaces y cgroups):** En Linux, los *namespaces* aíslan las vistas de procesos (PID), red, montajes, usuarios e IPC; los *cgroups* limitan y auditan el consumo de recursos (CPU, memoria, E/S). Todos los contenedores comparten el mismo kernel del host; una falla en el kernel puede comprometer al anfitrión.
- **Máquinas virtuales:** Cada máquina ejecuta su propio kernel independiente sobre un hipervisor; proveen una frontera de aislamiento más fuerte a nivel de hardware y virtualización.

---

## 8. Principios de diseño, confianza y cadena de suministro

### 8.1 Principios generales de diseño (Saltzer y Schroeder, 1975)

La seguridad perfecta es inalcanzable en sistemas complejos; en su lugar, se busca minimizar riesgos e impactos aplicando de manera consistente un conjunto de principios clásicos basados en el aislamiento de componentes y la mediación controlada de sus interacciones:

1. **Principio de economía de mecanismos (*Economy of mechanism / Simplicity*):**
   El diseño del sistema debe ser lo más simple y compacto posible. Los sistemas complejos contienen inherentemente más fallas de programación (*bugs*) y aumentan la probabilidad de que los usuarios cometan errores de configuración por falta de comprensión. Además, un diseño simple minimiza la superficie de ataque (*attack surface*), es decir, todos los puntos de interacción expuestos que un atacante puede aprovechar. Toda funcionalidad o línea de código que no sea estrictamente imprescindible debe ser omitida.

2. **Principio de valores por defecto seguros (*Fail-safe defaults*):**
   El estado predeterminado de cualquier recurso debe ser la ausencia total de permisos. Es computacional y lógicamente más robusto definir reglas explícitas que permitan el acceso a sujetos autorizados que intentar enumerar todas las condiciones bajo las cuales un acceso deba denegarse. Funciona bajo el modelo de una puerta cerrada con llave: si no se presenta explícitamente la llave, el paso queda bloqueado por omisión.

3. **Principio de mediación completa (*Complete mediation*):**
   Cada acceso a cada recurso debe ser verificado de manera continua frente a la política de seguridad. El sistema no debe confiar en comprobaciones previas para permitir accesos subsiguientes sin verificación. Esto exige disponer de mecanismos infalsificables para identificar con total certeza el origen de cada solicitud.

4. **Principio de menor privilegio (*Principle of Least Authority / Privilege - POLA*):**
   Cualquier sujeto, proceso o subsistema debe operar utilizando estrictamente el nivel mínimo de privilegios indispensable para realizar su tarea, y únicamente durante el tiempo requerido. De este modo, si un componente resulta comprometido, el atacante solo heredará una elevación de privilegios mínima e insuficiente para controlar el sistema completo.

5. **Principio de separación de privilegios (*Privilege separation*):**
   Es preferible subdividir el sistema en múltiples componentes independientes y acotados bajo el principio de menor privilegio, antes que concentrar todas las facultades en un único componente privilegiado monolítico. Si uno de los componentes falla o es vulnerado, el daño queda contenido dentro de sus límites operativos.

6. **Principio del mecanismo común mínimo (*Least common mechanism*):**
   Debe minimizarse la cantidad de mecanismos y estructuras de datos compartidas por múltiples usuarios y procesos. Los recursos compartidos a nivel del sistema operativo representan potenciales vías de fuga de información y canales encubiertos (*side-channels*). Siempre que sea posible, es más seguro implementar funcionalidades en bibliotecas de espacio de usuario (privadas para cada proceso) en lugar de utilizar variables o estructuras globales en el kernel.

7. **Principio de diseño abierto (*Open design*):**
   La seguridad del sistema no debe basarse en el secreto de su diseño, arquitectura o algoritmos (rechazo absoluto a la *seguridad por oscuridad*). Generaliza el principio de Kerckhoffs de la criptografía: un sistema debe mantenerse seguro incluso si el adversario conoce completamente su funcionamiento interno y tiene acceso a su código fuente. La seguridad debe residir exclusivamente en la protección de parámetros secretos (como claves criptográficas o credenciales).

8. **Principio de aceptabilidad psicológica (*Psychological acceptability / Usability*):**
   Las reglas y mecanismos de seguridad deben ser fáciles de usar, intuitivos y comprensibles para los usuarios. Si una medida de protección es excesivamente compleja, engorrosa o interfiere de forma disruptiva con el flujo normal de trabajo, los usuarios buscarán la manera de eludirla o cometerán errores operativos, anulando las garantías del sistema. Además, debe ser claro para los usuarios por qué dichas reglas son necesarias.

### 8.2 El rol de la confianza y la cadena de suministro

- **Supuestos de confianza:** Cualquier mecanismo o procedimiento de seguridad se sustenta en supuestos implícitos (confianza en el fabricante del sistema operativo, en la prueba correcta de los parches o en la integridad del compilador). Si los supuestos de base resultan falsos, el esquema de seguridad colapsa.
- **Seguridad en la cadena de suministro (*Supply Chain*):**
  - Un hash criptográfico solo es útil si su valor esperado se obtiene a través de un canal confiable.
  - Es fundamental verificar firmas digitales de paquetes y metadatos desde repositorios auténticos.
  - Proteger los entornos de construcción (*build systems*), distribución y dependencias de terceros.
  - Una firma válida garantiza la autenticidad e integridad del paquete distribuido, pero no certifica la ausencia de vulnerabilidades o código malicioso en el código fuente original.