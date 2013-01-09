-- MySQL dump 10.13  Distrib 5.5.29, for Win64 (x86)
--
-- Host: localhost    Database: anti_plagiarism
-- ------------------------------------------------------
-- Server version	5.5.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group` int(11) DEFAULT NULL,
  `program_name` varchar(40) DEFAULT NULL,
  `language` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignments_user_groups1_idx` (`user_group`),
  KEY `fk_assignments_languages1_idx` (`language`),
  CONSTRAINT `fk_assignments_languages1` FOREIGN KEY (`language`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_user_groups1` FOREIGN KEY (`user_group`) REFERENCES `user_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
INSERT INTO `assignments` VALUES (1,1,'baca',1);
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_new_lines`
--

DROP TABLE IF EXISTS `code_new_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_new_lines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `line_number` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_code_new_lines_programme_codes1_idx` (`program_id`),
  KEY `index3` (`position`,`program_id`),
  CONSTRAINT `fk_code_new_lines_programme_codes1` FOREIGN KEY (`program_id`) REFERENCES `programme_codes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_new_lines`
--

LOCK TABLES `code_new_lines` WRITE;
/*!40000 ALTER TABLE `code_new_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_new_lines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_replacements`
--

DROP TABLE IF EXISTS `code_replacements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `code_replacements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `programme` int(11) DEFAULT NULL,
  `fragment` text,
  `replacement` text,
  PRIMARY KEY (`id`),
  KEY `fk_code_replacements_assignments1_idx` (`programme`),
  CONSTRAINT `fk_code_replacements_assignments1` FOREIGN KEY (`programme`) REFERENCES `assignments` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_replacements`
--

LOCK TABLES `code_replacements` WRITE;
/*!40000 ALTER TABLE `code_replacements` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_replacements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fingerprints`
--

DROP TABLE IF EXISTS `fingerprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fingerprints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_code` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `hash_value` int(11) DEFAULT NULL,
  `k_parameter` int(11) DEFAULT NULL,
  `t_parameter` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fingerprints_programme_codes1_idx` (`source_code`),
  KEY `index3` (`source_code`,`hash_value`,`k_parameter`,`t_parameter`),
  CONSTRAINT `fk_fingerprints_programme_codes1` FOREIGN KEY (`source_code`) REFERENCES `programme_codes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fingerprints`
--

LOCK TABLES `fingerprints` WRITE;
/*!40000 ALTER TABLE `fingerprints` DISABLE KEYS */;
/*!40000 ALTER TABLE `fingerprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  `comment` varchar(5) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'c++','//','cpp');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matched`
--

DROP TABLE IF EXISTS `matched`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matched` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source1` int(11) DEFAULT NULL,
  `source2` int(11) DEFAULT NULL,
  `match_count` int(11) DEFAULT NULL,
  `all_count` int(11) DEFAULT NULL,
  `k_value` int(11) DEFAULT NULL,
  `t_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_matched_programme_codes1_idx` (`source1`),
  KEY `fk_matched_programme_codes2_idx` (`source2`),
  KEY `index4` (`source2`,`source1`,`k_value`,`t_value`),
  CONSTRAINT `fk_matched_programme_codes1` FOREIGN KEY (`source1`) REFERENCES `programme_codes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_matched_programme_codes2` FOREIGN KEY (`source2`) REFERENCES `programme_codes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matched`
--

LOCK TABLES `matched` WRITE;
/*!40000 ALTER TABLE `matched` DISABLE KEYS */;
INSERT INTO `matched` VALUES (1,1,3,0,0,10,20),(2,3,2,0,0,10,20);
/*!40000 ALTER TABLE `matched` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `the_match` int(11) DEFAULT NULL,
  `fingerprint1` int(11) DEFAULT NULL,
  `fingerprint2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_matches_matched1_idx` (`the_match`),
  KEY `fk_matches_fingerprints1_idx` (`fingerprint1`),
  KEY `fk_matches_fingerprints2_idx` (`fingerprint2`),
  CONSTRAINT `fk_matches_fingerprints1` FOREIGN KEY (`fingerprint1`) REFERENCES `fingerprints` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_matches_fingerprints2` FOREIGN KEY (`fingerprint2`) REFERENCES `fingerprints` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_matches_matched1` FOREIGN KEY (`the_match`) REFERENCES `matched` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parameters`
--

DROP TABLE IF EXISTS `parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parameters` (
  `name` varchar(30) NOT NULL,
  `value` int(11) DEFAULT NULL,
  `string_value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parameters`
--

LOCK TABLES `parameters` WRITE;
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` VALUES ('k-value',10,NULL),('output_path',NULL,'C:/'),('t-value',20,NULL),('temp',10,NULL);
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programme_codes`
--

DROP TABLE IF EXISTS `programme_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programme_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `programme` int(11) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `file` text,
  PRIMARY KEY (`id`),
  KEY `fk_programme_codes_assignments1_idx` (`programme`),
  KEY `fk_programme_codes_users1_idx` (`user`),
  CONSTRAINT `fk_programme_codes_assignments1` FOREIGN KEY (`programme`) REFERENCES `assignments` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_programme_codes_users1` FOREIGN KEY (`user`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programme_codes`
--

LOCK TABLES `programme_codes` WRITE;
/*!40000 ALTER TABLE `programme_codes` DISABLE KEYS */;
INSERT INTO `programme_codes` VALUES (1,1,1,'#include <iostream>\n#include <string>\nusing namespace std;\n\nint main(){\n    string a;\n    cin >> a;\n    cout << a.substr(0,a.find(\"@\"));\n    system(\"pause\");\n    return 0;\n}\n'),(2,1,1,'#include <cstdlib>\n#include <iostream>\n#include <fstream>\n#include <string>\n#include <sstream>\n#include <windows.h>\n#include <winsock2.h>\n#include <process.h>\n#include <list>\n#include <ctime>\n#define MAX_CLIENTS 10\n\nusing namespace std;\n\nstruct User {//klasa uzytkownika\n       string login;\n       SOCKET socket;//gniazdo do komunikacji z uzytkownikiem\n       bool authorized;//czy uzytkownik zostal uwierzytelniony\n       unsigned int session_key;//klucz ktorego uzywamy do komunikacji z danym uzytkowanikiem\n       unsigned int session_modulo;\n       unsigned int message_count;//licznik wiadomosci do wygenerowania nowego klucza\n       HANDLE mutex;\n\n       User(SOCKET asd):socket(asd),authorized(false),mutex(CreateMutex(NULL,false,NULL)){};\n\n       ~User() {\n               closesocket(socket);\n       }\n\n       friend bool operator==(User a, User b) {//operator potrzebny do usuwania z listy\n              return a.socket = b.socket;\n       }\n};\n\nSOCKET s;//gniazdo nasluchujace\nlist<User*> clients;//lista uzytkownikow\nCRITICAL_SECTION clients_access;\n//int client_count;\nWSADATA w;\nWSADATA wsaData;\nunsigned int* primes;//statyczna tablica wczytanych liczb pierwszych\nint primes_count;\n\nstring sha1(string mystring) {\n       //implementacja prawie-sha-1, na architekturze big-endian poprawnie implementuje sha-1,\n       //na architekturze little-endian(np.windows) podaje inny, choc rownie bezpieczny hash\n       unsigned int h[5];\n       h[0] = 0x67452301;\n       h[1] = 0xEFCDAB89;\n       h[2] = 0x98BADCFE;\n       h[3] = 0x10325476;\n       h[4] = 0xC3D2E1F0;\n       unsigned int chunks = (mystring.length()>>6)+1;\n       if (mystring.length()<<26>>26 > 55)\n          ++chunks;\n       unsigned int *message = new unsigned int[chunks*16];\n       memset(message,0,64*chunks);\n       unsigned int size = chunks*16;\n       for (size_t i=0;i<mystring.length();++i) {\n           message[i>>2] |= mystring[i]<<(8*(3-i<<30>>30));\n       }\n       {\n       size_t p = mystring.length();\n       message[p>>2] |= 0x10<<(8*(3-p<<30>>30));\n       while (p>>2<<2 < size-2) {\n           message[p>>2] |= 0x0000<<(8*(3-p<<30>>30));\n           ++p;\n       }\n       }\n       message[size-1] = (unsigned int)mystring.length();\n       //message[size-2] = (mystring.length()<<32);//jesli dopuszczamy length(dluzszy niz 32 bity)\n       for (unsigned int i=0;i<chunks;++i) {\n           unsigned int *chunk_data = new unsigned int[80];\n           unsigned int j;\n           for (j=0;j<16;++j)\n               chunk_data[j]=message[16*i+j];\n           for (j=16;j<80;++j) {\n               chunk_data[j] = (chunk_data[j-3]^chunk_data[j-8]^chunk_data[j-14]^chunk_data[j-16]);\n               chunk_data[j] = chunk_data[j]<<1 | chunk_data[j]>>31;\n           }\n           unsigned int a = h[0];\n           unsigned int b = h[1];\n           unsigned int c = h[2];\n           unsigned int d = h[3];\n           unsigned int e = h[4];\n           unsigned int f;\n           unsigned int k;\n\n           for (int j=0;j<80;++j) {\n               if (i<20) {\n                   f = (b & c) | ((~b) & d);\n                   k = 0x5A827999;\n               } else if (i<40) {\n                   f = b ^ c ^ d;\n                   k = 0x6ED9EBA1;\n               } else if (i<60) {\n                   f = (b & c) | (b & d) | (c & d);\n                   k = 0x8F1BBCDC;\n               } else {\n                   f = b ^ c ^ d;\n                   k = 0xCA62C1D6;\n               }\n\n               unsigned int temp = (a<<5 | a>>27)+f + e + k + chunk_data[j];\n               e = d;\n               d = c;\n               c = (b<<30 | b>>2);\n               b = a;\n               a = temp;\n           }\n           h[0]+=a;\n           h[1]+=b;\n           h[2]+=c;\n           h[3]+=d;\n           h[4]+=e;\n       }\n       delete message;\n       stringstream s;\n       s << hex << h[0] << h[1] << h[2] << h[3] << h[4];\n       string returnstring;\n       s >> returnstring;\n       return returnstring;\n}\n\nvoid generateRSA(unsigned int& public_key, unsigned int& private_key, unsigned int& modulo) {\n     //funkcja do generowania nowych kluczy rsa\n     srand (time(NULL));\n     modulo = 0;\n     while (modulo<(1<<8)) {//nie chcemy aby klucz byl za maly\n         //na poczatek losujemy 2 liczby pierwsze\n         unsigned int p = primes[rand()%primes_count];\n         unsigned int q = primes[rand()%primes_count];\n         unsigned int temp_modulo = (p-1)*(q-1);\n         modulo = p*q;\n         //liczymy ich iloczyn i jego funkcje eulera\n         if (modulo>>16) {//nie chcemy aby klucz byl za duzy\n            modulo = 0;\n            continue;\n         }\n         public_key=0;\n         while (true) {\n             public_key = (rand()%p)+2;//bierzemy losowy klucz publiczny\n             p = public_key;\n             q=1;\n             while (p!=1) {//i szukamy odpowiadajacego klucza prywatnego\n               p+=public_key;\n               ++q;\n               while (p>temp_modulo)\n                  p-=temp_modulo;\n               if (q>temp_modulo)\n                  break;//nie zawsze wyjdzie(p musi byc wzgl. pierwsze z temp_modulo), probujemy az wyjdzie\n             }\n             if (q<temp_modulo) {\n               private_key = q;//jesli wyjdzie to super\n               break;\n             }\n         }\n     }\n}\n\nvoid Decode(char* input, char* output,int key,int modulo) {\n     //dekodowanie rsa wiadomosci do ciagu znakow o dwukrotnie mniejszej dlugosci\n     int len = strlen(input)>>1;\n     for (int i=0;i<len;++i) {\n         unsigned int a = ((((unsigned char)input[2*i])-5)<<8)|((unsigned char)input[2*i+1]);\n         unsigned int b=1;\n         for (int j=0;j<key;++j)\n             b=(b*a)%modulo;\n         output[i] = (char)b;\n     }\n     output[len] = \'\\0\';\n}\n\nvoid Encode(char* input, char* output,int key,int modulo) {\n     //kodowanie rsa wiadomosci do ciagu znakow o dwukrotnie wiekszej dlugosci\n     int len = strlen(input);\n     for (int i=0;i<len;++i) {\n         unsigned int a = (int)(unsigned char)input[i];\n         unsigned int b=1;\n         for (int j=0;j<key;++j)\n             b=(b*a)%modulo;\n         output[2*i] = (char)(b>>8)+5;\n         output[2*i+1] = (char)b;\n     }\n     output[2*len] = \'\\0\';\n}\n\nvoid sendToOne(User* user, char* message) {//wyslanie wiadomosci do uzytkownika\n     unsigned int a,b,c;\n     stringstream ss;\n     if (user->message_count<2) {//jesli osiagniemy zaraz limit wiadomosci\n        char* new_message;\n        generateRSA(a,b,c);//to generujemy nowy klucz\n        ss << \"KEYUP!@#\" << a << \";\" << c << \";\";\n        ss << message;\n        message = \"\";\n        new_message = new char[1024];\n        ss.getline(new_message,1024);//tworzymy nowa wiadomosc\n        {\n        char temp[strlen(new_message)<<1+1];\n        Encode(new_message,temp,user->session_key,user->session_modulo);//kodujemy ja starym kluczem i wysylamy\n        send(user->socket,temp,strlen(temp),0);\n        }\n        user->session_key = b;//nastepnie zmieniamy klucz na nowy\n        user->session_modulo = c;\n        srand(time(NULL));\n        user->message_count = 90+rand()%20;//i ustawiamy nowy licznik\n     } else {\n       {//w przeciwnym wypadku po prostu kodujemy i wysylamy\n        char temp[strlen(message)<<1+1];\n        Encode(message,temp,user->session_key,user->session_modulo);\n        send(user->socket,temp,strlen(temp)+1,0);\n        }\n        --user->message_count;//nie zapominajac o liczniku\n     }\n}\n\nvoid sendToAll(User* a, string message) {//rozeslanie wiadomosci do wszystkich\n     string ss=message;\n     ss = a->login + \";:@!#\" + ss;//dopisujemy autora\n     char* new_message = (char*)ss.c_str();\n     EnterCriticalSection(&clients_access);\n     for (list<User*>::iterator ii=clients.begin(); ii!=clients.end();++ii) {//i wysylamy do kazdego z osobna\n         if ((*ii)->authorized)\n            sendToOne(*ii,new_message);\n     }\n     LeaveCriticalSection(&clients_access);\n}\n\nvoid handleClient(void* params) {//watek do obslugi pojedynczego uzytkownika\n     SOCKET sock = *(SOCKET*)params;\n     User* user = new User(sock);//tworzymy uzytkownika\n     clients.push_back(user);//dodajemy go do listy\n     LeaveCriticalSection(&clients_access);\n     char* buffor2;\n     string author;\n     buffor2 = new char[1024];\n     recv(user->socket,buffor2,1024,0);//odczytujemy wiadomosc identyfikujaca\n     author = \"Klienci/\";\n     author += buffor2;\n     {\n      ifstream plik(author.c_str());//czytamy klucz ktorym mamy wyslac pierwszy komunikat\n      plik >> user->session_key >> user->session_modulo;\n      plik.close();\n     }\n     unsigned int private_key;\n     unsigned int public_key;\n     unsigned int modulo;\n     generateRSA(public_key,private_key,modulo);//generujemy klucz sesyjny\n     {\n       stringstream ss;\n       ss << public_key << \";\" << modulo;\n       memset(buffor2,\'\\0\',sizeof(buffor2));\n       ss.getline(buffor2,1024);\n     }\n     {\n     char buffor[2*strlen(buffor2)+1];//kodujemy klucz sesyjny znanym nam kluczem klienta i wysylamy\n     Encode(buffor2,buffor, user->session_key,user->session_modulo);\n     send(user->socket,buffor,strlen(buffor)+1,0);\n     }\n     user->session_key = private_key;//ustawiamy kluczsesyjny i licznik wiadomosci\n     user->session_modulo = modulo;\n     srand(time(NULL));\n     user->message_count = 90+rand()%20;\n     int a=3;\n     while (a>0 && !user->authorized) {//czekamy na proby autoryzacji\n           recv(user->socket,buffor2,1024,0);\n           --user->message_count;\n           string ss;\n           {\n           char buffor[strlen(buffor2)>>1+1];//zaczynamy od dekodowania wiadomosci\n           Decode(buffor2,buffor,user->session_key,user->session_modulo);\n           ss = buffor;\n           }\n           author = ss.substr(0,ss.find(\";\"));//sprawdzamy login\n           ss = ss.substr(ss.find(\";\")+1);\n           ss = sha1(ss);//tworzymy hash wyslanego hasla\n           ifstream plik(author.c_str());\n           plik.getline(buffor2,1024);\n           if (ss==buffor2) {//i porownujemy go z zapisanym wpliku\n              user->authorized = true;\n              send(user->socket,\"1\",1,0);\n              user->login= author;//jesli sie zgadza to potwierdzamy uwierzytelnianie\n           } else {\n              --a;\n              if (a)\n                 send(user->socket,\"2\",1,0);\n              else\n                  send(user->socket,\"3\",1,0);\n\n           }\n     }\n     int temp = 10;\n     while (temp && user->authorized) {//dopoki polaczenie jest otwarte\n           temp = recv(user->socket,buffor2,1024,0);//czekamy na wiadomosc\n           Sleep(100);\n           string tempstr;\n           {\n           char buffor[strlen(buffor2)>>1+1];//dekodujemy wiadomosc\n           Decode(buffor2,buffor,user->session_key,user->session_modulo);\n           --user->message_count;\n           tempstr = buffor;\n           }\n           sendToAll(user, tempstr);//i wysylamy do wszystkich\n     }\n     delete buffor2;\n     EnterCriticalSection(&clients_access);\n     //po zakonczeniu pracy z uzytkownikiem usuwamy go z listy\n     clients.remove(user);\n     LeaveCriticalSection(&clients_access);\n     delete user;\n}\n\nint main(int argc, char *argv[])\n{\n    if (WSAStartup(0x101,&wsaData)!=0) {\n		cout << \"WSAStartup failed.\\n\";\n		return 1;\n    }\n\n    ifstream plik(\"pierwsze.txt\");//wczytywanie liczb pierwszych\n    plik >> primes_count;\n    primes = new unsigned int[primes_count];\n    for (int i=0;i<primes_count;++i)\n        plik >> primes[i];\n\n	{//mozna odkomentowac jesli chce sie dodac uzytkownika\n    /*\n    //tu wpisujemy haslo\n    string ss = sha1(\"1234\");\n    //a tu login\n    ofstream plik(\"mama\");\n    plik << ss;\n    plik.close();\n    system(\"pause\");\n    */\n    //jak chcemy uzyskac nowy klucz klienta to mozna odkomentowac ta czesc\n    /*\n    unsigned int a,b,c;\n    generateRSA(a,b,c);\n    cout << a << endl<< b << endl<< c << endl;\n    system(\"pause\");\n    */\n    }\n\n    struct hostent *host;\n    SOCKADDR_IN local;\n    SOCKET server;\n\n    local.sin_family=AF_INET;\n    local.sin_addr.s_addr=INADDR_ANY;\n    local.sin_port=htons(60000);\n	server=socket(AF_INET,SOCK_STREAM,0);\n	if(server==INVALID_SOCKET)\n    {\n        return 0;\n    }\n    if(bind(server,(sockaddr*)&local,sizeof(local))!=0)\n    {\n        return 0;\n    }\n\n    if(listen(server,10)!=0)\n    {\n        return 0;\n    }\n\n\n    sockaddr_in from;\n    int fromlen=sizeof(from);\n\n    InitializeCriticalSection( &clients_access );\n\n    while(true)\n    {\n        char bufor[5];\n        char buffor[1024];\n\n        SOCKET client=accept(server,(struct sockaddr*)&from,&fromlen);\n        //odbieramy polaczenie i kierujemy je do nowego watku\n        EnterCriticalSection(&clients_access);\n		_beginthread(handleClient,0,(void*)&client);\n\n        //close the client socket\n\n    }\n\n    system(\"pause\");\n    closesocket(server);\n    WSACleanup();\n    return 0;\n}\n'),(3,1,2,'#include <cstdlib>\n#include <iostream>\n#include <fstream>\n#include <string>\n#include <sstream>\n#include <windows.h>\n#include <winsock2.h>\n#include <process.h>\n#include <list>\n#include <ctime>\n#define MAX_CLIENTS 10\n\nusing namespace std;\n\nstruct User {//klasa uzytkownika\n       string login;\n       SOCKET socket;//gniazdo do komunikacji z uzytkownikiem\n       bool authorized;//czy uzytkownik zostal uwierzytelniony\n       unsigned int session_key;//klucz ktorego uzywamy do komunikacji z danym uzytkowanikiem\n       unsigned int session_modulo;\n       unsigned int message_count;//licznik wiadomosci do wygenerowania nowego klucza\n       HANDLE mutex;\n\n       User(SOCKET asd):socket(asd),authorized(false),mutex(CreateMutex(NULL,false,NULL)){};\n\n       ~User() {\n               closesocket(socket);\n       }\n\n       friend bool operator==(User a, User b) {//operator potrzebny do usuwania z listy\n              return a.socket = b.socket;\n       }\n};\n\nSOCKET s;//gniazdo nasluchujace\nlist<User*> clients;//lista uzytkownikow\nCRITICAL_SECTION clients_access;\n//int client_count;\nWSADATA w;\nWSADATA wsaData;\nunsigned int* primes;//statyczna tablica wczytanych liczb pierwszych\nint primes_count;\n\nstring sha1(string mystring) {\n       //implementacja prawie-sha-1, na architekturze big-endian poprawnie implementuje sha-1,\n       //na architekturze little-endian(np.windows) podaje inny, choc rownie bezpieczny hash\n       unsigned int h[5];\n       h[0] = 0x67452301;\n       h[1] = 0xEFCDAB89;\n       h[2] = 0x98BADCFE;\n       h[3] = 0x10325476;\n       h[4] = 0xC3D2E1F0;\n       unsigned int chunks = (mystring.length()>>6)+1;\n       if (mystring.length()<<26>>26 > 55)\n          ++chunks;\n       unsigned int *message = new unsigned int[chunks*16];\n       memset(message,0,64*chunks);\n       unsigned int size = chunks*16;\n       for (size_t i=0;i<mystring.length();++i) {\n           message[i>>2] |= mystring[i]<<(8*(3-i<<30>>30));\n       }\n       {\n       size_t p = mystring.length();\n       message[p>>2] |= 0x10<<(8*(3-p<<30>>30));\n       while (p>>2<<2 < size-2) {\n           message[p>>2] |= 0x0000<<(8*(3-p<<30>>30));\n           ++p;\n       }\n       }\n       message[size-1] = (unsigned int)mystring.length();\n       //message[size-2] = (mystring.length()<<32);//jesli dopuszczamy length(dluzszy niz 32 bity)\n       for (unsigned int i=0;i<chunks;++i) {\n           unsigned int *chunk_data = new unsigned int[80];\n           unsigned int j;\n           for (j=0;j<16;++j)\n               chunk_data[j]=message[16*i+j];\n           for (j=16;j<80;++j) {\n               chunk_data[j] = (chunk_data[j-3]^chunk_data[j-8]^chunk_data[j-14]^chunk_data[j-16]);\n               chunk_data[j] = chunk_data[j]<<1 | chunk_data[j]>>31;\n           }\n           unsigned int a = h[0];\n           unsigned int b = h[1];\n           unsigned int c = h[2];\n           unsigned int d = h[3];\n           unsigned int e = h[4];\n           unsigned int f;\n           unsigned int k;\n\n           for (int j=0;j<80;++j) {\n               if (i<20) {\n                   f = (b & c) | ((~b) & d);\n                   k = 0x5A827999;\n               } else if (i<40) {\n                   f = b ^ c ^ d;\n                   k = 0x6ED9EBA1;\n               } else if (i<60) {\n                   f = (b & c) | (b & d) | (c & d);\n                   k = 0x8F1BBCDC;\n               } else {\n                   f = b ^ c ^ d;\n                   k = 0xCA62C1D6;\n               }\n\n               unsigned int temp = (a<<5 | a>>27)+f + e + k + chunk_data[j];\n               e = d;\n               d = c;\n               c = (b<<30 | b>>2);\n               b = a;\n               a = temp;\n           }\n           h[0]+=a;\n           h[1]+=b;\n           h[2]+=c;\n           h[3]+=d;\n           h[4]+=e;\n       }\n       delete message;\n       stringstream s;\n       s << hex << h[0] << h[1] << h[2] << h[3] << h[4];\n       string returnstring;\n       s >> returnstring;\n       return returnstring;\n}\n\nvoid generateRSA(unsigned int& public_key, unsigned int& private_key, unsigned int& modulo) {\n     //funkcja do generowania nowych kluczy rsa\n     srand (time(NULL));\n     modulo = 0;\n     while (modulo<(1<<8)) {//nie chcemy aby klucz byl za maly\n         //na poczatek losujemy 2 liczby pierwsze\n         unsigned int p = primes[rand()%primes_count];\n         unsigned int q = primes[rand()%primes_count];\n         unsigned int temp_modulo = (p-1)*(q-1);\n         modulo = p*q;\n         //liczymy ich iloczyn i jego funkcje eulera\n         if (modulo>>16) {//nie chcemy aby klucz byl za duzy\n            modulo = 0;\n            continue;\n         }\n         public_key=0;\n         while (true) {\n             public_key = (rand()%p)+2;//bierzemy losowy klucz publiczny\n             p = public_key;\n             q=1;\n             while (p!=1) {//i szukamy odpowiadajacego klucza prywatnego\n               p+=public_key;\n               ++q;\n               while (p>temp_modulo)\n                  p-=temp_modulo;\n               if (q>temp_modulo)\n                  break;//nie zawsze wyjdzie(p musi byc wzgl. pierwsze z temp_modulo), probujemy az wyjdzie\n             }\n             if (q<temp_modulo) {\n               private_key = q;//jesli wyjdzie to super\n               break;\n             }\n         }\n     }\n}\n\nvoid Decode(char* input, char* output,int key,int modulo) {\n     //dekodowanie rsa wiadomosci do ciagu znakow o dwukrotnie mniejszej dlugosci\n     int len = strlen(input)>>1;\n     for (int i=0;i<len;++i) {\n         unsigned int a = ((((unsigned char)input[2*i])-5)<<8)|((unsigned char)input[2*i+1]);\n         unsigned int b=1;\n         for (int j=0;j<key;++j)\n             b=(b*a)%modulo;\n         output[i] = (char)b;\n     }\n     output[len] = \'\\0\';\n}\n\nvoid Encode(char* input, char* output,int key,int modulo) {\n     //kodowanie rsa wiadomosci do ciagu znakow o dwukrotnie wiekszej dlugosci\n     int len = strlen(input);\n     for (int i=0;i<len;++i) {\n         unsigned int a = (int)(unsigned char)input[i];\n         unsigned int b=1;\n         for (int j=0;j<key;++j)\n             b=(b*a)%modulo;\n         output[2*i] = (char)(b>>8)+5;\n         output[2*i+1] = (char)b;\n     }\n     output[2*len] = \'\\0\';\n}\n\nvoid sendToOne(User* user, char* message) {//wyslanie wiadomosci do uzytkownika\n     unsigned int a,b,c;\n     stringstream ss;\n     if (user->message_count<2) {//jesli osiagniemy zaraz limit wiadomosci\n        char* new_message;\n        generateRSA(a,b,c);//to generujemy nowy klucz\n        ss << \"KEYUP!@#\" << a << \";\" << c << \";\";\n        ss << message;\n        message = \"\";\n        new_message = new char[1024];\n        ss.getline(new_message,1024);//tworzymy nowa wiadomosc\n        {\n        char temp[strlen(new_message)<<1+1];\n        Encode(new_message,temp,user->session_key,user->session_modulo);//kodujemy ja starym kluczem i wysylamy\n        send(user->socket,temp,strlen(temp),0);\n        }\n        user->session_key = b;//nastepnie zmieniamy klucz na nowy\n        user->session_modulo = c;\n        srand(time(NULL));\n        user->message_count = 90+rand()%20;//i ustawiamy nowy licznik\n     } else {\n       {//w przeciwnym wypadku po prostu kodujemy i wysylamy\n        char temp[strlen(message)<<1+1];\n        Encode(message,temp,user->session_key,user->session_modulo);\n        send(user->socket,temp,strlen(temp)+1,0);\n        }\n        --user->message_count;//nie zapominajac o liczniku\n     }\n}\n\nvoid sendToAll(User* a, string message) {//rozeslanie wiadomosci do wszystkich\n     string ss=message;\n     ss = a->login + \";:@!#\" + ss;//dopisujemy autora\n     char* new_message = (char*)ss.c_str();\n     EnterCriticalSection(&clients_access);\n     for (list<User*>::iterator ii=clients.begin(); ii!=clients.end();++ii) {//i wysylamy do kazdego z osobna\n         if ((*ii)->authorized)\n            sendToOne(*ii,new_message);\n     }\n     LeaveCriticalSection(&clients_access);\n}\n\nvoid handleClient(void* params) {//watek do obslugi pojedynczego uzytkownika\n     SOCKET sock = *(SOCKET*)params;\n     User* user = new User(sock);//tworzymy uzytkownika\n     clients.push_back(user);//dodajemy go do listy\n     LeaveCriticalSection(&clients_access);\n     char* buffor2;\n     string author;\n     buffor2 = new char[1024];\n     recv(user->socket,buffor2,1024,0);//odczytujemy wiadomosc identyfikujaca\n     author = \"Klienci/\";\n     author += buffor2;\n     {\n      ifstream plik(author.c_str());//czytamy klucz ktorym mamy wyslac pierwszy komunikat\n      plik >> user->session_key >> user->session_modulo;\n      plik.close();\n     }\n     unsigned int private_key;\n     unsigned int public_key;\n     unsigned int modulo;\n     generateRSA(public_key,private_key,modulo);//generujemy klucz sesyjny\n     {\n       stringstream ss;\n       ss << public_key << \";\" << modulo;\n       memset(buffor2,\'\\0\',sizeof(buffor2));\n       ss.getline(buffor2,1024);\n     }\n     {\n     char buffor[2*strlen(buffor2)+1];//kodujemy klucz sesyjny znanym nam kluczem klienta i wysylamy\n     Encode(buffor2,buffor, user->session_key,user->session_modulo);\n     send(user->socket,buffor,strlen(buffor)+1,0);\n     }\n     user->session_key = private_key;//ustawiamy kluczsesyjny i licznik wiadomosci\n     user->session_modulo = modulo;\n     srand(time(NULL));\n     user->message_count = 90+rand()%20;\n     int a=3;\n     while (a>0 && !user->authorized) {//czekamy na proby autoryzacji\n           recv(user->socket,buffor2,1024,0);\n           --user->message_count;\n           string ss;\n           {\n           char buffor[strlen(buffor2)>>1+1];//zaczynamy od dekodowania wiadomosci\n           Decode(buffor2,buffor,user->session_key,user->session_modulo);\n           ss = buffor;\n           }\n           author = ss.substr(0,ss.find(\";\"));//sprawdzamy login\n           ss = ss.substr(ss.find(\";\")+1);\n           ss = sha1(ss);//tworzymy hash wyslanego hasla\n           ifstream plik(author.c_str());\n           plik.getline(buffor2,1024);\n           if (ss==buffor2) {//i porownujemy go z zapisanym wpliku\n              user->authorized = true;\n              send(user->socket,\"1\",1,0);\n              user->login= author;//jesli sie zgadza to potwierdzamy uwierzytelnianie\n           } else {\n              --a;\n              if (a)\n                 send(user->socket,\"2\",1,0);\n              else\n                  send(user->socket,\"3\",1,0);\n\n           }\n     }\n     int temp = 10;\n     while (temp && user->authorized) {//dopoki polaczenie jest otwarte\n           temp = recv(user->socket,buffor2,1024,0);//czekamy na wiadomosc\n           Sleep(100);\n           string tempstr;\n           {\n           char buffor[strlen(buffor2)>>1+1];//dekodujemy wiadomosc\n           Decode(buffor2,buffor,user->session_key,user->session_modulo);\n           --user->message_count;\n           tempstr = buffor;\n           }\n           sendToAll(user, tempstr);//i wysylamy do wszystkich\n     }\n     delete buffor2;\n     EnterCriticalSection(&clients_access);\n     //po zakonczeniu pracy z uzytkownikiem usuwamy go z listy\n     clients.remove(user);\n     LeaveCriticalSection(&clients_access);\n     delete user;\n}\n\nint main(int argc, char *argv[])\n{\n    if (WSAStartup(0x101,&wsaData)!=0) {\n		cout << \"WSAStartup failed.\\n\";\n		return 1;\n    }\n\n    ifstream plik(\"pierwsze.txt\");//wczytywanie liczb pierwszych\n    plik >> primes_count;\n    primes = new unsigned int[primes_count];\n    for (int i=0;i<primes_count;++i)\n        plik >> primes[i];\n\n	{//mozna odkomentowac jesli chce sie dodac uzytkownika\n    /*\n    //tu wpisujemy haslo\n    string ss = sha1(\"1234\");\n    //a tu login\n    ofstream plik(\"mama\");\n    plik << ss;\n    plik.close();\n    system(\"pause\");\n    */\n    //jak chcemy uzyskac nowy klucz klienta to mozna odkomentowac ta czesc\n    /*\n    unsigned int a,b,c;\n    generateRSA(a,b,c);\n    cout << a << endl<< b << endl<< c << endl;\n    system(\"pause\");\n    */\n    }\n\n    struct hostent *host;\n    SOCKADDR_IN local;\n    SOCKET server;\n\n    local.sin_family=AF_INET;\n    local.sin_addr.s_addr=INADDR_ANY;\n    local.sin_port=htons(60000);\n	server=socket(AF_INET,SOCK_STREAM,0);\n	if(server==INVALID_SOCKET)\n    {\n        return 0;\n    }\n    if(bind(server,(sockaddr*)&local,sizeof(local))!=0)\n    {\n        return 0;\n    }\n\n    if(listen(server,10)!=0)\n    {\n        return 0;\n    }\n\n\n    sockaddr_in from;\n    int fromlen=sizeof(from);\n\n    InitializeCriticalSection( &clients_access );\n\n    while(true)\n    {\n        char bufor[5];\n        char buffor[1024];\n\n        SOCKET client=accept(server,(struct sockaddr*)&from,&fromlen);\n        //odbieramy polaczenie i kierujemy je do nowego watku\n        EnterCriticalSection(&clients_access);\n		_beginthread(handleClient,0,(void*)&client);\n\n        //close the client socket\n\n    }\n\n    system(\"pause\");\n    closesocket(server);\n    WSACleanup();\n    return 0;\n}\n');
/*!40000 ALTER TABLE `programme_codes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger new_file after insert on programme_codes for each row begin
	call fingerprint_file(new.id);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index2` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,'pierwszoroczniaki');
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `user_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_users_user_groups_idx` (`user_group`),
  KEY `index3` (`name`,`user_group`),
  CONSTRAINT `fk_users_user_groups` FOREIGN KEY (`user_group`) REFERENCES `user_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'babiuch',1),(2,'czlowiek z reklamowka',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-01-09 14:38:48
