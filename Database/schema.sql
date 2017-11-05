CREATE DATABASE enpro DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
use enpro;
create table chaside(
  id integer not null auto_increment,
  preg varchar(256),
  primary key(id)
);
create table kuder(
  id integer not null auto_increment,
  preg varchar(256),
  primary key(id)
);
create table admin(
  id integer not null auto_increment,
  chaside boolean default 0,
  kuder boolean default 0,
  fmod datetime,
  primary key(id)
);
create table kuderdesc(
  id integer not null auto_increment,
  cod integer,
  nombre varchar(128),
  cont text,
  primary key(id)
);
create table kudercar(
  id integer not null auto_increment,
  cod varchar(4),
  nombre varchar(256),
  carreras varchar(512),
  primary key(id)
);
create table estudiante_kuderdesc(
  estudiante_id integer not null,
  kuderdesc_id integer not null,
  percentil integer,
  primary key(estudiante_id, kuderdesc_id),
  foreign key(estudiante_id)
  references estudiante(id)
  on delete cascade,
  foreign key(kuderdesc_id)
  references kuderdesc(id)
  on delete cascade
);
create table estudiante_kudercar(
  estudiante_id integer not null,
  kudercar_id integer not null,
  primary key(estudiante_id, kudercar_id),
  foreign key(estudiante_id)
  references estudiante(id)
  on delete cascade,
  foreign key(kudercar_id)
  references kudercar(id)
  on delete cascade
);

create table intereseschaside(
  id integer not null auto_increment,
  letra char(1),
  nombre varchar(128),
  intereses varchar(256),
  primary key(id)
);
create table aptitudeschaside(
  id integer not null auto_increment,
  letra char(1),
  nombre varchar(128),
  aptitudes varchar(256),
  primary key(id)
);
create table estudiante(
  id integer not null auto_increment,
  nombres varchar(256),
  apellidos varchar(256),
  colegio varchar(256),
  fnac date,
  username varchar(128) unique,
  sexo boolean,
  intereseschaside_id integer null,
  aptitudeschaside_id integer null,
  primary key(id),
  foreign key(intereseschaside_id)
  references intereseschaside(id)
  on delete cascade,
  foreign key(aptitudeschaside_id)
  references aptitudeschaside(id)
  on delete cascade
);
-- solo se guarda las repuestas positivas
create table chaside_estudiante(
  id integer not null auto_increment,
  estudiante_id integer not null,
  chaside_id integer not null,
  primary key(id),
  foreign key(estudiante_id)
  references estudiante(id)
  on delete cascade,
  foreign key(chaside_id)
  references chaside(id)
  on delete cascade
);

insert into kuderdesc values(
  null,
  0,
  'Actividad al Aire Libre',
  ' a ti te gusta pasar la mayor parte del tiempo en el campo, en los bosques o en el mar. Te agrada cultivar plantas o cuidar a los animales, etc. En cambio, tus resultados dicen que no te sentirás muy a gusto en una fábrica, en un laboratorio o en una oficina.'
);
insert into kuderdesc values(
  null,
  1,
  'Interés Mecánico',
  ' tu pérfil indica interés para trabajar con máquinas y herramientas, construir o arreglar objetos mecánicos, artefactos eléctricos, muebles, etc.'
);
insert into kuderdesc values(
  null,
  2,
  'Interés para el Cálculo',
  ' te encanta trabajar con números, resolver problemas numéricos, aplicar fórmulas, resolver series.'
);
insert into kuderdesc values(
  null,
  3,
  'Interés Científico',
  ' encuentras placer en investigar la razón de los hechos o de las cosas, en descubrir sus causas y en resolver problemas de distinta índole, sin duda gracias a personas como tú se hace posible el progreso de la ciencia.'
);
insert into kuderdesc values(
  null,
  4,
  'Interés Persuasivo',
  ' a ti te gusta tratar con personas, te agrada compartir e imponer tus puntos de vista, convencer a los demás, vender artículos, etc.'
);
insert into kuderdesc values(
  null,
  5,
  'Interés Artístico Plástico',
  ' eres de aquellas personas a quienes les gusta hacer trabajos de creación tipo manual, usando combinaciones de colores, materiales, formas y diseños.'
);
insert into kuderdesc values(
  null,
  6,
  'Interés Literario',
  ' eres de las personas a las que les gusta la lectura y encuentran placer en expresar sus ideas en forma oral o escrita.'
);
insert into kuderdesc values(
  null,
  7,
  'Interés Musical',
  ' tu pérfil denota un marcado gusto para tocar instrumentos musicales, cantar, bailar, leer sobre música, estudiar la vida de destacados compositores, asistir a conciertos, etc.'
);
insert into kuderdesc values(
  null,
  8,
  'Interés por el Servicio Social',
  ' presentas un gran interés para servir a los demás, teniendo como prioridad a los necesitados, a los enfermos, a los niños y a los ancianos.'
);
insert into kuderdesc values(
  null,
  9,
  'Interés en el Trabajo de Oficina',
  ' te gusta todo tipo de trabajos de escritorio, manejar archivos, agendar actividades, trabajos que requieren exactitud y precisión.'
);

insert into kudercar values(
  null,
  '0',
  'Trabajo al Aire Libre',
  'Ciencias del Mar,Ecología,Geología,Ingeniería Agronómica,Ingeniería Forestal,Ingeniería de Minas,Ejército,Policia,Profesor de Ecucación Física'
);
insert into kudercar values(
  null,
  '1',
  'Mecánico',
  'Aviación,Electromecánica,Física,Ingeniería Civil,Ingeniería Eléctrica,Ingeniería Industrial,Ingeniería Mecánica,Ingeniería Metalúrgica,Ingeniería Química,Mecánica Automotriz,Mecánica Industrial'
);
insert into kudercar values(
  null,
  '2',
  'Cálculo',
  'Contaduría Pública,Auditoría,Economía,Estadística,Ingeniería en Sistemas,Profesor de Matemáticas,Informática'
);
insert into kudercar values(
  null,
  '3',
  'Científico',
  'Antropología,Arqueología,Astronomía,Biología,Ingeniería Electrónica,Ingeniería de Alimentos,Medicina,Cirugía,Veterinaria,Odontología,Psicología,Química,Química Farmacéutica,Sociología,Técnicos de Laboratorios'
);
insert into kudercar values(
  null,
  '4',
  'Persuasivo',
  'Agentes de Publicidad,Comunicación Social,Escritores,Marketing,Derecho,Abogados,Maestros,Personal de Ventas'
);
insert into kudercar values(
  null,
  '5',
  'Artístico Plástico',
  'Arquitectura,Decoración de Interiores,Pintura,Marketing y Diseño'
);
insert into kudercar values(
  null,
  '6',
  'Literario',
  'Bibliotecología,Profesor de filosofía,Profesor de Literatura,Escritores,Periodismo,Derecho'
);
insert into kudercar values(
  null,
  '7',
  'Musical',
  'Actuación,Compositor Musical,Directores de Orquesta,Músicos,Profesores de Música'
);
insert into kudercar values(
  null,
  '8',
  'Servicio Social',
  'Bibliotecología,Enfermería,Medicina,Cirugía,Odontología,Pedagogía,Psicología,Trabajo Social,Sacerdote'
);
insert into kudercar values(
  null,
  '9',
  'Trabajo de Oficina',
  'Archivista,Cajeros,Contadores,Mecanografía,Secretaría Ejecutiva,Secretarias'
);
insert into kudercar values(
  null,
  '01',
  'Aire Libre - Mecánico',
  'Ingeniería Agronómica(Esp. Maquinaría Agrícola),Ingeniería Civil(Esp. Hidráulica),Ingeniería Civil(Esp. Vías de Comunicación),Ingeniería de Minas,Ingeniería Petrolera,Topógrafos'
);
insert into kudercar values(
  null,
  '02',
  'Aire Libre - Cálculo',
  'Ingeniería Agronómica(Esp. Economía),Ingeniería Agronómica(Esp. Estadística)'
);
insert into kudercar values(
  null,
  '03',
  'Aire Libre - Científico',
  'Antropología,Arqueología,Geología,Ingeniería Agronómica(Esp. Parasitología),Ingeniería Forestal,Médicos Veterinarios'
);
insert into kudercar values(
  null,
  '08',
  'Aire Libre - Servicio Social',
  'Profesor de Educación Física, Trabajo Social'
);
insert into kudercar values(
  null,
  '12',
  'Mecánico - Cálculo',
  'Ingeniería Civil,Ingeniería Mecánica'
);
insert into kudercar values(
  null,
  '13',
  'Mecánico - Científico',
  'Fisioterapeuta,Geología,Ingeniería Civil,Ingeniería de minas,Ingeniería Industrial,Ingeniería Mecánica,Ingeniería Química'
);
insert into kudercar values(
  null,
  '14',
  'Mecánico - Persuasivo',
  'Ingeniería Industrial,Mercadotecnia'
);
insert into kudercar values(
  null,
  '15',
  'Mecánico - Artístico',
  'Arquitectura,Decoración de Interiores,Dibujantes Publicitarios,Profesores de Artes Manuales'
);
insert into kudercar values(
  null,
  '17',
  'Mecánico - Musical',
  'Ingenieros de sonido'
);
insert into kudercar values(
  null,
  '18',
  'Mécanico - Servicio Social',
  'Profesor de materias técnicas'
);
insert into kudercar values(
  null,
  '23',
  'Cálculo - Científico',
  'Astronomía,Economía,Física,Ingeniería Civil,Ingeniería Industrial,Ingeniería Mecánica,Ingeniería Eléctrica,Ingeniería Química,Matemática,Química,Profesor de Matemática'
);
insert into kudercar values(
  null,
  '24',
  'Cálculo - Persuasivo',
  'Economía'
);
insert into kudercar values(
  null,
  '25',
  'Cálculo - Artístico-Plástico',
  'Arquitectura,Ingeniería Civil'
);
insert into kudercar values(
  null,
  '28',
  'Cálculo - Servicio Social',
  'Economía,Profesor de Matemática,Profesores de Materias Exactas'
);
insert into kudercar values(
  null,
  '29',
  'Cálculo - Trabajo de oficina',
  'Contaduría,Bibliotecología'
);
insert into kudercar values(
  null,
  '34',
  'Científico - Persuasivo',
  'Farmacéutica,Ingeniería Industrial,Profesores de Ciencias'
);
insert into kudercar values(
  null,
  '35',
  'Científico - Artístico-Plástico',
  'Arquitectura,Médico Cirujano,Odontología'
);
insert into kudercar values(
  null,
  '36',
  'Científico - Literario',
  'Medicina,Psicología'
);
insert into kudercar values(
  null,
  '37',
  'Científico - Musical',
  'Ingeniería en Sonido'
);
insert into kudercar values(
  null,
  '38',
  'Científico - Servicio Social',
  'Consejeros Vocacionales,Medicina,Nutricionista,Odontología,Profesor de Ciencias'
);
insert into kudercar values(
  null,
  '45',
  'Persuasivo - Artístico-Plástico',
  'Decorador de Interiores,Dibujante Publicitario'
);
insert into kudercar values(
  null,
  '46',
  'Persuasivo - Literario',
  'Escritor,Derecho,Periodismo,Profesor de Literatura'
);
insert into kudercar values(
  null,
  '47',
  'Persuasivo - Musical',
  'Actuación,Director de Orquesta,Profesor de Canto,Profesor de Música'
);
insert into kudercar values(
  null,
  '48',
  'Persuasivo - Servicio Social',
  'Comunicación Social,Consejero Vocacional,Pedagogía,Trabajo Social'
);
insert into kudercar values(
  null,
  '56',
  'Artístico-Plástico - Literario',
  'Actuación,Escritor'
);
insert into kudercar values(
  null,
  '58',
  'Artístico Plástico - Servicio Social',
  'Profesor de Artes Manuales'
);
insert into kudercar values(
  null,
  '67',
  'Literario - Musical',
  'Actuación,Profesor de Música'
);
insert into kudercar values(
  null,
  '68',
  'Literario - Servicio social',
  'Escritor,Periodismo,Profesor de Ciencias Sociales,Profesor de Filosofía,Trabajo Social'
);
insert into kudercar values(
  null,
  '69',
  'Literario - Trabajo de Oficina',
  'Bibliotecología,Secretaría'
);
insert into kudercar values(
  null,
  '78',
  'Musical - Servicio Social',
  'Músico, Profesor de Música,Baile'
);
insert into kudercar values(
  null,
  '89',
  'Servicio Social - Trabajo de Oficina',
  'Profesor'
);


insert into intereseschaside values(null, 'C', 'Administrativas y Contables',
'Organización,Supervisión,Orden,Análisis y síntesis,Colaboración,Cálculo');
insert into aptitudeschaside values(null, 'C', 'Administrativas y Contables',
'Persuasivo,Objetivo,Práctico,Tolerante,Responsable,Ambicioso');

insert into intereseschaside values(null, 'H', 'Humanísticas y Sociales',
'Precisión Verbal,Organización,Relación de Hechos,Lingüística,Orden,Justicia');
insert into aptitudeschaside values(null, 'H', 'Humanísticas y Sociales',
'Precisión Verbal,Organización,Relación de Hechos,Lingüística,Orden,Justicia');

insert into intereseschaside values(null, 'A', 'Artísticas',
'Estética,Lo Armónico,Lo Manual,Lo Visual,Lo Auditivo');
insert into aptitudeschaside values(null, 'A', 'Artísticas',
'Sensible,Imaginativo,Creativo,Detallista,Innovador,Intuitivo');

insert into intereseschaside values(null, 'S', 'Medicina y Ciencias de la Salud',
'Asistir,Investigar,Precisión,Analítico,Ayudar');
insert into aptitudeschaside values(null, 'S', 'Medicina y Ciencias de la Salud',
'Altruista,Solidario,Paciente,Comprensivo,Respetuoso,Persuasivo');

insert into intereseschaside values(null, 'I', 'Ingeniería y Computación',
'Cálculo,Científico,Manual,Exacto,Planificar');
insert into aptitudeschaside values(null, 'I', 'Ingeniería y Computación',
'Preciso,Práctico,Crítico,Analítico,Rígido');

insert into intereseschaside values(null, 'D', 'Defensa y Seguridad',
'Justicia,Equidad,Colaboración,Espíritu de Equipo,Liderazgo');
insert into aptitudeschaside values(null, 'D', 'Defensa y Seguridad',
'Arriesgado,Solidario,Valiente,Agresivo,Persuasivo');

insert into intereseschaside values(null, 'E', 'Ciencias Exactas y Agrarias',
'Investigación,Orden,Organización,Análisis y Síntesis,Numérico,Clasificar');
insert into aptitudeschaside values(null, 'E', 'Ciencias Exactas y Agrarias',
'Metódico,Analítico,Obervador,Introvertido,Paciente,Seguro');

insert into chaside values(null, '¿Aceptarías trabajar escribiendo artículos en la sección económica de un diario?');
insert into chaside values(null, '¿Te ofrecerías para organizar la despedida de soltero de uno de tus amigos?');
insert into chaside values(null, '¿Te gustaría dirigir un proyecto de urbanización en tu provincia?');
insert into chaside values(null, '¿A una frustración siempre opones un pensamiento positivo?');
insert into chaside values(null, '¿Te dedicarías a socorrer a personas accidentadas o atacadas por asaltantes?');
insert into chaside values(null, '¿Cuando eras chico, te interesaba saber cómo estaban construidos tus juguetes?');
insert into chaside values(null, '¿Te interesan más los misterios de la naturaleza que los secretos de la tecnología?');
insert into chaside values(null, '¿Escuchás atentamente los problemas que te plantean tus amigos?');
insert into chaside values(null, '¿Te ofrecerías para explicar a tus compañeros un determinado tema que ellos no entendieron?');
insert into chaside values(null, '¿Sos exigente y crítico con tu equipo de trabajo?');
insert into chaside values(null, '¿Te atrae armar rompecabezas o puzzles?');
insert into chaside values(null, '¿Podés establecer la diferencia conceptual entre macroeconomía y microeconomía?');
insert into chaside values(null, '¿Usar uniforme te hace sentir distinto, importante?');
insert into chaside values(null, '¿Participarías como profesional en un espectáculo de acrobacia aérea?');
insert into chaside values(null, '¿Organizas tu dinero de manera que te alcance hasta el próximo cobro?');
insert into chaside values(null, '¿Convencés fácilmente a otras personas sobre la validez de tus argumentos?');
insert into chaside values(null, '¿Estás informado sobre los nuevos descubrimientos que se están realizando sobre el universo?');
insert into chaside values(null, '¿Ante una situación de emergencia actuás rápidamente?');
insert into chaside values(null, '¿Cuando tenés que resolver un problema matemático, perseverás hasta encontrar la solución?');
insert into chaside values(null, '¿Si te convocara tu club preferido para planificar, organizar y dirigir un campo de deportes, aceptarías?');
insert into chaside values(null, '¿Sos el que pone un toque de alegría en las fiestas?');
insert into chaside values(null, '¿Crees que los detalles son tan importantes como el todo?');
insert into chaside values(null, '¿Te sentirías a gusto trabajando en un ámbito hospitalario?');
insert into chaside values(null, '¿Te gustaría participar para mantener el orden ante grandes desórdenes y tragedias?');
insert into chaside values(null, '¿Pasarías varias horas leyendo algún libro de tu interés?');
insert into chaside values(null, '¿Planificás detalladamente tus trabajos antes de empezar?');
insert into chaside values(null, '¿Entablás una relación casi personal con tu computadora?');
insert into chaside values(null, '¿Disfrutarias modelando con arcilla?');
insert into chaside values(null, '¿Ayudás habitualmente a los no videntes a cruzar la calle?');
insert into chaside values(null, '¿Considerás importante que desde la escuela primaria se fomente la actitud crítica y la participación activa?');
insert into chaside values(null, '¿Aceptarías que las mujeres formaran parte de las fuerzas armadas bajo las mismas normas que los hombres?');
insert into chaside values(null, '¿Te gustaría crear nuevas técnicas para descubrir las patologías de algunas enfermedades a través del microscopio?');
insert into chaside values(null, '¿Participarías en una campaña de prevención contra la enfermedad de Chagas?');
insert into chaside values(null, '¿Te interesan los temas relacionados al pasado y a la evolución del hombre?');
insert into chaside values(null, '¿Te incluirías en un proyecto de investigación de los movimientos sísmicos y sus consecuencias?');
insert into chaside values(null, '¿Fuera de los horarios escolares, dedicás algún día de la semana a la realización de actividades corporales?');
insert into chaside values(null, '¿Te interesan las actividades de mucha acción y de reacción rápida en situaciones imprevistas y de peligro?');
insert into chaside values(null, '¿Te ofrecerías para colaborar como voluntario en los gabinetes espaciales de la NASA?');
insert into chaside values(null, '¿Te gusta más el trabajo manual que el trabajo intelectual?');
insert into chaside values(null, '¿Estarías dispuesto a renunciar a un momento placentero para ofrecer tu servicio como profesional?');
insert into chaside values(null, '¿Participarías de una investigación sobre la violencia en el fútbol?');
insert into chaside values(null, '¿Te gustaría trabajar en un laboratorio mientras estudiás?');
insert into chaside values(null, '¿Arriesgarías tu vida para salvar la vida de otro que no conoces?');
insert into chaside values(null, '¿Te agradaría hacer un curso de primeros auxilios?');
insert into chaside values(null, '¿Tolerarías empezar tantas veces como fuere necesario hasta obtener el logro deseado?');
insert into chaside values(null, '¿Distribuís tu horarios del día adecuadamente para poder hacer todo lo planeado?');
insert into chaside values(null, '¿Harías un curso para aprender a fabricar los instrumentos y/o piezas de las máquinas o aparatos con que trabajas?');
insert into chaside values(null, '¿Elegirías una profesión en la tuvieras que estar algunos meses alejado de tu familia, por ejemplo el marino?');
insert into chaside values(null, '¿Te radicarías en una zona agrícola-ganadera para desarrollar tus actividades como profesional?');
insert into chaside values(null, '¿Cuando estás en un grupo trabajando, te entusiasma producir ideas originales y que sean tenidas en cuenta?');
insert into chaside values(null, '¿Te resulta fácil coordinar un grupo de trabajo?');
insert into chaside values(null, '¿Te resultó interesante el estudio de las ciencias biológicas?');
insert into chaside values(null, '¿Si una gran empresa solicita un profesional como gerente de comercialización, te sentirías a gusto desempeñando ese rol?');
insert into chaside values(null, '¿Te incluirías en un proyecto nacional de desarrollo de la principal fuente de recursos de tu provincia?');
insert into chaside values(null, '¿Tenés interés por saber cuales son las causas que determinan ciertos fenómenos, aunque saberlo no altere tu vida?');
insert into chaside values(null, '¿Descubriste algún filósofo o escritor que haya expresado tus mismas ideas con antelación?');
insert into chaside values(null, '¿Desearías que te regalen algún instrumento musical para tu cumpleaños?');
insert into chaside values(null, '¿Aceptarías colaborar con el cumplimiento de las normas en lugares públicos?');
insert into chaside values(null, '¿Crees que tus ideas son importantes,y haces todo lo posible para ponerlas en práctica?');
insert into chaside values(null, '¿Cuando se descompone un artefacto en tu casa, te disponés prontamente a repararlo?');
insert into chaside values(null, '¿Formarías parte de un equipo de trabajo orientado a la preservación de la flora y la fauna en extinción?');
insert into chaside values(null, '¿Acostumbrás a leer revistas relacionadas con los últimos avances científicos y tecnológicos en el área de la salud?');
insert into chaside values(null, '¿Preservar las raíces culturales de nuestro país, te parece importante y necesario?');
insert into chaside values(null, '¿Te gustaría realizar una investigación que contribuyera a hacer más justa la distribución de la riqueza?');
insert into chaside values(null, '¿Te gustaría realizar tareas auxiliares en una nave, como por ejemplo izado y arriado de velas, pintura y conservación del casco, arreglo de averías, conservación de motores, etc?');
insert into chaside values(null, '¿Crees que un país debe poseer la más alta tecnología armamentista, a cualquier precio?');
insert into chaside values(null, '¿La libertad y la justicia son valores fundamentales en tu vida?');
insert into chaside values(null, '¿Aceptarías hacer una práctica en una industria de productos alimenticios en el sector de control de calidad?');
insert into chaside values(null, '¿Consideras que la salud pública debe ser prioritaria, gratuita y eficiente para todos?');
insert into chaside values(null, '¿Te interesaría investigar sobre alguna nueva vacuna?');
insert into chaside values(null, '¿En un equipo de trabajo, preferís el rol de coordinador?');
insert into chaside values(null, '¿En una discusión entre amigos, te ofrecés como mediador?');
insert into chaside values(null, '¿Estás de acuerdo con la formación de un cuerpo de soldados profesionales?');
insert into chaside values(null, '¿Lucharías por una causa justa hasta las últimas consecuencias?');
insert into chaside values(null, '¿Te gustaría investigar científicamente sobre cultivos agrícolas?');
insert into chaside values(null, '¿Harías un nuevo diseño de una prenda pasada de moda, ante una reunión imprevista?');
insert into chaside values(null, '¿Visitarías un observatorio astronómico para conocer en acción el funcionamiento de los aparatos?');
insert into chaside values(null, '¿Dirigirías el área de importación y exportación de una empresa?');
insert into chaside values(null, '¿Te inhibís al entrar a un lugar nuevo con gente desconocida?');
insert into chaside values(null, '¿Te gratificaría el trabajar con niños?');
insert into chaside values(null, '¿Harías el diseño de un afiche para una campaña contra el sida?');
insert into chaside values(null, '¿Dirigirías un grupo de teatro independiente?');
insert into chaside values(null, '¿Enviarías tu curriculum a una empresa automotriz que solicita gerente para su área de producción?');
insert into chaside values(null, '¿Participarías en un grupo de defensa internacional dentro de alguna fuerza armada?');
insert into chaside values(null, '¿Te costearías tus estudios trabajando en una auditoría?');
insert into chaside values(null, '¿Sos de los que defendés causas perdidas?');
insert into chaside values(null, '¿Ante una emergencia epidémica participarías en una campaña brindando tu ayuda?');
insert into chaside values(null, '¿Sabrías responder que significa ADN y ARN?');
insert into chaside values(null, '¿Elegirías una carrera cuyo instrumento de trabajo fuere la utilización de un idioma extranjero?');
insert into chaside values(null, '¿Trabajar con objetos te resulta más gratificante que trabajar con personas?');
insert into chaside values(null, '¿Te resultaría gratificante ser asesor contable en una empresa reconocida?');
insert into chaside values(null, '¿Ante un llamado solidario, te ofrecerías para cuidar a un enfermo?');
insert into chaside values(null, '¿Te atrae investigar sobre los misterios del universo, por ejemplo los agujeros negros?');
insert into chaside values(null, '¿El trabajo individual te resulta más rápido y efectivo que el trabajo grupal?');
insert into chaside values(null, '¿Dedicarías parte de tu tiempo a ayudar a personas de zonas carenciadas?');
insert into chaside values(null, '¿Cuando elegís tu ropa o decorás un ambiente, tenés en cuenta la combinación de los colores, las telas o el estilo de los muebles?');
insert into chaside values(null, '¿Te gustaría trabajar como profesional dirigiendo la construcción de una empresa hidroeléctrica?');
insert into chaside values(null, '¿Sabés qué es el PBI?');
-- kuder 1
insert into kuder values(null, 'En sus viajes, observar de preferencia la gente');
insert into kuder values(null, 'En sus viajes, observar de preferencia los paisajes');
insert into kuder values(null, 'En sus viajes, observar de preferencia los cultivos');
insert into kuder values(null, 'Ayudarse económicamente dedicando varias horas diarias a leerle a un ciego');
insert into kuder values(null, 'Ayudar económicamente llevando la estadística de vehículos que pasan por un retén');
insert into kuder values(null, 'Ayudarse económicamente haciendo encuestas entre el público');
insert into kuder values(null, 'Visitar lugares de diversión en una feria de pueblo');
insert into kuder values(null, 'Visitar la exposición de productos alimenticios caseros en una feria de pueblo');
insert into kuder values(null, 'Visitar la exposición de ganado en una feria de pueblo');
insert into kuder values(null, 'Hacer ejercicios de atletismo');
insert into kuder values(null, 'Ir a pescar');
insert into kuder values(null, 'Jugar fútbol');
insert into kuder values(null, 'Hojear libros y revistas en una librería');
insert into kuder values(null, 'Presenciar el ensayo de una orquesta');
insert into kuder values(null, 'Visitar un jardín zoológico');
insert into kuder values(null, 'Coleccionar autógrafos de personajes célebres');
insert into kuder values(null, 'Coleccionar mariposas');
insert into kuder values(null, 'Coleccionar muestras de madera');
insert into kuder values(null, 'Visitar una exposición de cuadros famosos');
insert into kuder values(null, 'Visitar una exposición de distintos medios de transporte');
insert into kuder values(null, 'Visitar una exposición de equipos de laboratorio');
insert into kuder values(null, 'Vender frutas');
insert into kuder values(null, 'Ser pianista profesional');
insert into kuder values(null, 'Cultivar hortalizas');
insert into kuder values(null, 'Dirigir la organización de una fiesta en un club social');
insert into kuder values(null, 'Decorar el salón para la fiesta');
insert into kuder values(null, 'Repartir las invitaciones para la fiesta');
insert into kuder values(null, 'Visitar un museo de ciencias');
insert into kuder values(null, 'Visitar una empresa periodística');
insert into kuder values(null, 'Visitar una fabrica de maquinas de escribir');
insert into kuder values(null, 'Leer para distraer una persona enferma');
insert into kuder values(null, 'Enseñar tretas a un perro');
insert into kuder values(null, 'Desarmar un juguete dañado para ver cómo se arregla');
insert into kuder values(null, 'Recibir clases de dibujo');
insert into kuder values(null, 'Recibir clases de biología');
insert into kuder values(null, 'Recibir clases de metalistería');
insert into kuder values(null, 'Construir pajareras');
insert into kuder values(null, 'Escribir artículos sobre las aves');
insert into kuder values(null, 'Dibujar las aves');
insert into kuder values(null, 'Tratar de arreglar una maquina de coser dañada');
insert into kuder values(null, 'Tocar piano');
insert into kuder values(null, 'Hacer el bosquejo de una escena interesante');
-- kuder 2
insert into kuder values(null, 'Leer un libro titulado “Cómo cultivar buenas frutas”');
insert into kuder values(null, 'Leer un libro titulado “Cómo trabajar con materiales plásticos”');
insert into kuder values(null, 'Leer un libro titulado “Cómo tomar fotos de animales en su ambiente natural”');
insert into kuder values(null, 'Tener a su cargo en un periódico la columna de “Consejos personales”');
insert into kuder values(null, 'Criar perros de raza');
insert into kuder values(null, 'Investigar la eficiencia de diversos medios de propaganda');
insert into kuder values(null, 'Ser autoridad en el juego de ajedrez');
insert into kuder values(null, 'Ser autoridad en erosión de suelos');
insert into kuder values(null, 'Ser autoridad en materia de propaganda gráfica');
insert into kuder values(null, 'Visitar un estudio cinematográfico');
insert into kuder values(null, 'Visitar una región montañosa célebre por sus paisajes');
insert into kuder values(null, 'Visitar un antiguo campo de batalla');
insert into kuder values(null, 'Leer sobre las actuaciones de los hombres y mujeres célebres en la vida pública');
insert into kuder values(null, 'Leer las opiniones de varios escritores sobre lo que sería el mundo ideal');
insert into kuder values(null, 'Leer cómo vivían los primeros colonizadores del país');
insert into kuder values(null, 'Trabajar como psicólogo profesional atendiendo consultas de carácter personal');
insert into kuder values(null, 'Cazara animales raros para un museo');
insert into kuder values(null, 'Pagar cheques al público en un banco');
insert into kuder values(null, 'Pertenecer a una sociedad que estudie los problemas del mundo contemporáneo');
insert into kuder values(null, 'Pertenecer a un club literario');
insert into kuder values(null, 'Pertenecer a una sociedad de aficionados a los estudios astronómicos');
insert into kuder values(null, 'Relacionarse con gente común y corriente');
insert into kuder values(null, 'Relacionarse con gente extravagante y de ideas raras');
insert into kuder values(null, 'Relacionarse con gente alegre y despreocupada');
insert into kuder values(null, 'Enseñar castellano a los extranjeros');
insert into kuder values(null, 'Vender pólizas de seguros');
insert into kuder values(null, 'Ser cocinero jefe de un restaurante de lujo');
insert into kuder values(null, 'Desarrollar nuevas variedades de flores');
insert into kuder values(null, 'Dirigir la propaganda para floristerías');
insert into kuder values(null, 'Atender pedidos telefónicos en una floristería');
insert into kuder values(null, 'Dirigir investigaciones sobre los métodos de la propaganda comercial');
insert into kuder values(null, 'Ser Decano de una Facultad Universitaria');
insert into kuder values(null, 'Ser experto en fotografía de colores');
insert into kuder values(null, 'Dibujar cuadros para un libro de historia universal');
insert into kuder values(null, 'Producir una nueva variedad de naranjas sin semillas');
insert into kuder values(null, 'Entrenar un grupo escénico ganador del primer puesto en un concurso nacional');
insert into kuder values(null, 'Costear en parte sus estudios trabajando como ayudante de laboratorio');
insert into kuder values(null, 'Costearlos en parte ayudando en la secretaría del plantel donde estudia');
insert into kuder values(null, 'Costear en parte sus estudios tocando en una orquesta');
insert into kuder values(null, 'Escribir un libro sobre la historia de la Cruz Roja');
insert into kuder values(null, 'Buscar datos que arrojen nueva luz sobre un célebre acontecimiento histórico');
insert into kuder values(null, 'Escribir una comedia musical');
-- kuder 3
insert into kuder values(null, 'Enseñar castellano');
insert into kuder values(null, 'Atender pedidos telefónicos en un almacén');
insert into kuder values(null, 'Hacer encuestas de opinión pública sobre temas de actualidad');
insert into kuder values(null, 'Estar encargado de compras para un gran almacén');
insert into kuder values(null, 'Estar encargado de entrevistar a los aspirantes a empleos en una empresa');
insert into kuder values(null, 'Trabajar en una hacienda ganadera');
insert into kuder values(null, 'Ser jefe de personal en una empresa');
insert into kuder values(null, 'Escribir para una revista artículos sobre la vida de animales raros');
insert into kuder values(null, 'Escribir la columna “Consejos personales” en un periódico');
insert into kuder values(null, 'Leer sobre métodos modernos empleados en los negocios');
insert into kuder values(null, 'Leer sobre las costumbres de los habitantes de otros países');
insert into kuder values(null, 'Leer sobre nuevos métodos de explotación agrícola');
insert into kuder values(null, 'Trabajar en una estación meteorológica en el Ártico');
insert into kuder values(null, 'Trabajar en una estación meteorológica en la ciudad');
insert into kuder values(null, 'Trabajar en una estación meteorológica en las montañas');
insert into kuder values(null, 'Tener fama como director de investigaciones científicas');
insert into kuder values(null, 'Tener fama como trabajador en el campo de acción social');
insert into kuder values(null, 'Tener fama como crítico literario');
insert into kuder values(null, 'Diseñar decoraciones para una obra teatral');
insert into kuder values(null, 'Hacer análisis químicos de un nuevo producto');
insert into kuder values(null, 'Escribir artículos acerca de cómo preparar en casa utensilios domésticos');
insert into kuder values(null, 'Entrevistar a las personas que soliciten la ayuda de la beneficencia');
insert into kuder values(null, 'Ensayar varios modelos de cartas de propaganda comercial para ver cuál produce mejor resultado');
insert into kuder values(null, 'Perfeccionar los métodos de trabajo de oficina para hacerlos más eficaces');
insert into kuder values(null, 'Redactar la página financiera de un periódico');
insert into kuder values(null, 'Preparar una nueva aleación de metales, más liviana y resistente');
insert into kuder values(null, 'Administrar un moderno campamento para obreros');
insert into kuder values(null, 'Visitar un museo de bellas artes');
insert into kuder values(null, 'Visitar el centro de diversiones de un barrio popular');
insert into kuder values(null, 'Visitar un celebre laboratorio de investigaciones médicas');
insert into kuder values(null, 'Asumir la responsabilidad de despedir empleados deficientes en una empresa');
insert into kuder values(null, 'Asumir la responsabilidad para llamar la atención a empleados cuyo rendimiento no es satisfactorio');
insert into kuder values(null, 'Asumir la responsabilidad de emplear el personal nuevo en una empresa');
insert into kuder values(null, 'Hacer un diccionario de dichos populares');
insert into kuder values(null, 'Descubrir un remedio contra el asma');
insert into kuder values(null, 'Implantar mejores métodos de trabajo en una empresa grande');
insert into kuder values(null, 'Leer un libro sobre la historia del arte dramático');
insert into kuder values(null, 'Leer un libro sobre las primitivas formas de la música');
insert into kuder values(null, 'Leer un libro sobre la influencia del lenguaje en el comportamiento');
insert into kuder values(null, 'Hacer análisis químico de nuevos productos comerciales');
insert into kuder values(null, 'Trabajar en el perfeccionamiento del “pulmón artificial” para que proporcione mayor comodidad al enfermo');
insert into kuder values(null, 'Confeccionar gráficas del estado financiero de una empresa');
-- kuder 4
insert into kuder values(null, 'Repartir hojas volantes a los automóviles que se detienen en una esquina');
insert into kuder values(null, 'Contar el número de automóviles que pasan por una esquina a distintas horas');
insert into kuder values(null, 'Dirigir el tráfico en una esquina');
insert into kuder values(null, 'Reeducar a los niños lisiados por medio de ejercicios físicos');
insert into kuder values(null, 'Cultivar hortalizas para la venta');
insert into kuder values(null, 'Enseñar la confección de objetos de mimbre');
insert into kuder values(null, 'Recolectar dinero para una obra de beneficencia');
insert into kuder values(null, 'Redactar informes diarios sobre el progreso de la campaña de recolección de estos fondos');
insert into kuder values(null, 'Contabilizar los fondos recolectados a medida que estos van ingresando');
insert into kuder values(null, 'Hacerse cargo de los preparativos para una boda con numerosos invitados');
insert into kuder values(null, 'Repartir las invitaciones para la boda');
insert into kuder values(null, 'Escribir un comentario en la prensa sobre su celebración');
insert into kuder values(null, 'Escribir novelas');
insert into kuder values(null, 'Dirigir investigaciones sobre los efectos psicológicos de la música');
insert into kuder values(null, 'Confeccionar objetos de cerámica');
insert into kuder values(null, 'Investigar la eficiencia de los métodos para incrementar ventas');
insert into kuder values(null, 'Clasificar las cartas en una oficina de correos');
insert into kuder values(null, 'Criar pollos');
insert into kuder values(null, 'Escribir en un periódico la página dedicada a sucesos de actualidad');
insert into kuder values(null, 'Dictar conferencias populares sobre Química');
insert into kuder values(null, 'Ayudar a los jóvenes a descubrir su vocación');
insert into kuder values(null, 'Tener una persona para que siempre le ayude a resolver sus problemas');
insert into kuder values(null, 'Tener una persona para que ocasionalmente le resuelva sus problemas');
insert into kuder values(null, 'Resolver sus problemas sin consultar con nadie');
insert into kuder values(null, 'Trabajar como supervisor de ventas en un gran almacén');
insert into kuder values(null, 'Dirigir investigaciones sobre la televisión');
insert into kuder values(null, 'Dirigir programas recreativos en una institución de beneficencia');
insert into kuder values(null, 'Controlar el trabajo de varias mecanógrafas');
insert into kuder values(null, 'Entrevistar personas que hacen solicitud de empleo');
insert into kuder values(null, 'Trabajar como secretario(a) privado(a)');
insert into kuder values(null, 'Dibujar tiras cómicas');
insert into kuder values(null, 'Redactar propaganda para artículos eléctricos');
insert into kuder values(null, 'Cultivar una huerta');
insert into kuder values(null, 'Ensayar la hechura de dulces cuya receta usted no conoce');
insert into kuder values(null, 'Contar cuentos a los niños');
insert into kuder values(null, 'Pintar acuarelas');
insert into kuder values(null, 'Hacer investigaciones químicas');
insert into kuder values(null, 'Entrevistar a las personas que solicitan empleo');
insert into kuder values(null, 'Escribir reportajes para los periódicos');
insert into kuder values(null, 'Bosquejar una escena interesante');
insert into kuder values(null, 'Ensayar varios tipos de aeromodelos para ver cuál resulta mejor');
insert into kuder values(null, 'Escribir un ensayo imitando el estilo de un determinado escritor');
-- kuder 5
insert into kuder values(null, 'Vender boletas para una función de aficionados');
insert into kuder values(null, 'Preparar los programas y boletas para la función');
insert into kuder values(null, 'Actuar como tesorero de la función');
insert into kuder values(null, 'Calcular el costo de la fabricación de un nuevo modelo de lavadoras');
insert into kuder values(null, 'Convencer a un grupo de capitalistas para que financie la fabricación de estas lavadoras');
insert into kuder values(null, 'Enseñar a la gente el funcionamiento del nuevo modelo de lavadoras');
insert into kuder values(null, 'Analizar los resultados de encuestas hechas al público');
insert into kuder values(null, 'Escribir editoriales para un periódico');
insert into kuder values(null, 'Enseñar trabajos manuales en un asilo de niños desamparados');
insert into kuder values(null, 'Leer acerca de las causas de varias enfermedades');
insert into kuder values(null, 'Leer acerca de cómo lograron éxito los grandes capitanes de la industria');
insert into kuder values(null, 'Leer acerca de los métodos empleados en la cría de ganado');
insert into kuder values(null, 'Asistir a una reunión donde la mayoría de los individuos le es desconocida');
insert into kuder values(null, 'Asistir a una reunión en la que usted conoce a casi todos los invitados');
insert into kuder values(null, 'Asistir a una reunión donde sólo la mitad de los invitados le es conocida');
insert into kuder values(null, 'Vender materiales y equipos para los artículos pintores');
insert into kuder values(null, 'Producir semillas para la venta');
insert into kuder values(null, 'Criar ratones blancos para uso científico');
insert into kuder values(null, 'Hacer experimentos de laboratorio');
insert into kuder values(null, 'Confeccionar muebles');
insert into kuder values(null, 'Vender pólizas de seguro');
insert into kuder values(null, 'Pesar encomiendas postales para determinar el porte que deben llevar');
insert into kuder values(null, 'Seleccionar manuscritos enviados para publicación en una revista');
insert into kuder values(null, 'Ensayar nuevos modelos de automóviles para introducirles otras mejoras');
insert into kuder values(null, 'Ser experto en la talla de piedras preciosas');
insert into kuder values(null, 'Dirigir investigaciones para encontrar un nuevo sustituto al caucho');
insert into kuder values(null, 'Ser comentarista musical de una radioemisora');
insert into kuder values(null, 'Ayudar a cuidar a los enfermos');
insert into kuder values(null, 'Vender instrumentos musicales');
insert into kuder values(null, 'Reparar artefactos de uso casero');
insert into kuder values(null, 'Diseñar flores');
insert into kuder values(null, 'Dirigir la fabricación de floreros');
insert into kuder values(null, 'Perfeccionar los métodos para la fabricación de floreros');
insert into kuder values(null, 'Trabajar como casero en un restaurante de gran movimiento');
insert into kuder values(null, 'Enseñar a los niños la construcción de aeromodelos');
insert into kuder values(null, 'Llevar el registro de las investigaciones médicas que adelanta un científico');
insert into kuder values(null, 'Dirigir un campo de juegos para niños pobres');
insert into kuder values(null, 'Ser cocinero de un restaurante');
insert into kuder values(null, 'Vender productos químicos');
insert into kuder values(null, 'Reunir un buen equipo de herramientas para trabajar madera');
insert into kuder values(null, 'Formar un álbum con las reproducciones de sus cuadros favoritos');
insert into kuder values(null, 'Tomar un botiquín para casos de emergencia');
-- kuder 6
insert into kuder values(null, 'Dirigir una función teatral de aficionados');
insert into kuder values(null, 'Organizar la impresión de programas y boletos para la función');
insert into kuder values(null, 'Escribir el argumento de la pieza teatral que se va a representar');
insert into kuder values(null, 'Jugar a las damas con una persona que generalmente le gana a usted');
insert into kuder values(null, 'Jugar a las damas con una persona que rara vez le gana a usted');
insert into kuder values(null, 'Jugar a las damas con una persona que juegue más o menos como usted');
insert into kuder values(null, 'Redactar un aviso de propaganda para un nuevo modelo de lavadora');
insert into kuder values(null, 'Calcular el precio de costo para la fabricación de esta lavadora');
insert into kuder values(null, 'Vender lavadoras');
insert into kuder values(null, 'Escribir en un periódico la columna “Se rumora en la ciudad”');
insert into kuder values(null, 'Escribir en un periódico la columna “Consejos personales”');
insert into kuder values(null, 'Escribir en un periódico la columna “Cómo cuidar el jardín”');
insert into kuder values(null, 'Ser explorador');
insert into kuder values(null, 'Ser dibujante proyectista');
insert into kuder values(null, 'Ser inventor');
insert into kuder values(null, 'Trabajar en la cosecha de café');
insert into kuder values(null, 'Trabajar como tractorista en una hacienda');
insert into kuder values(null, 'Trabajar en un laboratorio de productos químicos');
insert into kuder values(null, 'Estudiar el arte de hablar en público');
insert into kuder values(null, 'Estudiar sociología');
insert into kuder values(null, 'Estudiar composición literaria');
insert into kuder values(null, 'Manejar una máquina calculadora');
insert into kuder values(null, 'Ensamblar máquinas calculadoras en una fábrica');
insert into kuder values(null, 'Vender máquinas calculadoras');
insert into kuder values(null, 'Construir lanchas');
insert into kuder values(null, 'Intervenir en el arreglo de conflictos laborales');
insert into kuder values(null, 'Componer música');
insert into kuder values(null, 'Ser el mejor vendedor de tractores y otros implementos agrícolas');
insert into kuder values(null, 'Ser contador público juramentado');
insert into kuder values(null, 'Ser autoridad en materia de impuestos');
insert into kuder values(null, 'Perfeccionar métodos de trabajo de oficina en empresas importantes');
insert into kuder values(null, 'Ser enfermero(a) de profesión');
insert into kuder values(null, 'Hacer ensayos para obtener mejores recetas de pastelería');
insert into kuder values(null, 'Reparar un daño en la plancha eléctrica');
insert into kuder values(null, 'Cortar la leña para prender la estufa');
insert into kuder values(null, 'Escribir una carta a maquina por petición de un amigo');
insert into kuder values(null, 'Manejar un almacén de música');
insert into kuder values(null, 'Hacer planos arquitectónicos');
insert into kuder values(null, 'Investigar el nivel de vida de distintos barrios de la ciudad');
insert into kuder values(null, 'Examinar un nuevo juguete mecánico para ver como funciona');
insert into kuder values(null, 'Jugar a las damas');
insert into kuder values(null, 'Jugar ajedrez');
-- kuder 7
insert into kuder values(null, 'Llevar la contabilidad de una empresa importante');
insert into kuder values(null, 'Desarrollar nuevas variedades de flores');
insert into kuder values(null, 'Ser psicólogo profesional y atender consultas personales');
insert into kuder values(null, 'Hacer de la pesca un medio para ganar la vida');
insert into kuder values(null, 'Seleccionar en un cafetal cafetos viejos para eliminarlos');
insert into kuder values(null, 'Pintar automóviles en una fábrica');
insert into kuder values(null, 'Ser visitador(a) social');
insert into kuder values(null, 'Ser secretario(a) privado(a) de una persona célebre');
insert into kuder values(null, 'Preparar la propaganda para una casa Editorial');
insert into kuder values(null, 'Escribir estampas de la vida real para una revista');
insert into kuder values(null, 'Escribir artículos sobre la cría de aves de corral');
insert into kuder values(null, 'Escribir artículos sobre la aplicación de primeros auxilios');
insert into kuder values(null, 'Trabajar como mesero(a) en un restaurante');
insert into kuder values(null, 'Seleccionar listas de personas para enviarles propaganda');
insert into kuder values(null, 'Cuidar enfermos');
insert into kuder values(null, 'Modelar objetos de arcilla');
insert into kuder values(null, 'Escribir artículos sobre recursos psicológicos para persuadir');
insert into kuder values(null, 'Ser consueta en una obra teatral de aficionados');
insert into kuder values(null, 'Ser médico');
insert into kuder values(null, 'Ser escultor');
insert into kuder values(null, 'Ser periodista');
insert into kuder values(null, 'Contestar por escrito consultas sobre máquinas de escribir');
insert into kuder values(null, 'Estudiar la demanda que tienen las maquinas de escribir');
insert into kuder values(null, 'Tener a su cargo la reparación de máquinas de escribir');
insert into kuder values(null, 'Estudiar métodos de propaganda usados durante la guerra');
insert into kuder values(null, 'Estudiar sistemas para mejorar los trabajos de oficina');
insert into kuder values(null, 'Hacer un estudio acerca del movimiento demográfico del país');
insert into kuder values(null, 'Corregir una prueba de imprenta');
insert into kuder values(null, 'Lavar platos');
insert into kuder values(null, 'Preparar la comida');
insert into kuder values(null, 'Enseñar arquitectura');
insert into kuder values(null, 'Solicitar propaganda para una revista');
insert into kuder values(null, 'Reparar relojes');
insert into kuder values(null, 'Preparar la comida');
insert into kuder values(null, 'Reparar un juguete dañado');
insert into kuder values(null, 'Darle un mensaje a una persona');
insert into kuder values(null, 'Tomar parte en una expedición en busca de animales raros');
insert into kuder values(null, 'Tomar parte en una expedición para combatir epidemias');
insert into kuder values(null, 'Trabajar en una entidad de beneficencia');
insert into kuder values(null, 'Ser pintor-retratista');
insert into kuder values(null, 'Dirigir investigaciones sobre las causas de los terremotos');
insert into kuder values(null, 'Ser ingeniero mecánico');
-- kuder 8
insert into kuder values(null, 'Ayudar a las familias que reciben asistencia económica, a equilibrar sus presupuestos');
insert into kuder values(null, 'Catalogar libros en una biblioteca');
insert into kuder values(null, 'Ser un experto en el cuidado de árboles');
insert into kuder values(null, 'Vender en un almacén');
insert into kuder values(null, 'Trabajar en una hacienda ganadera');
insert into kuder values(null, 'Trabajar en una casa Editorial');
insert into kuder values(null, 'Ser profesor de matemáticas');
insert into kuder values(null, 'Ser director de extensión cultural en una gran universidad');
insert into kuder values(null, 'Ser profesor de lenguas extranjeras');
insert into kuder values(null, 'Tomar un curso de correspondencia comercial');
insert into kuder values(null, 'Tomar un curso de artes gráficas');
insert into kuder values(null, 'Tomar un curso de ventas');
insert into kuder values(null, 'Dibujar planos de arquitectura');
insert into kuder values(null, 'Elaborar propaganda para una nueva urbanización');
insert into kuder values(null, 'Escribir artículos comentando nuevas ideas sobre construcciones');
insert into kuder values(null, 'Comprar artículos costosos utilizando el sistema de crédito');
insert into kuder values(null, 'Pedir prestado el dinero para comprar estos artículos');
insert into kuder values(null, 'Economizar el dinero que se necesita para adquirirlos');
insert into kuder values(null, 'Decorar muebles');
insert into kuder values(null, 'Vigilar a los trabajadores en una plantación de caña de azúcar');
insert into kuder values(null, 'Criar aves de corral');
insert into kuder values(null, 'Ayudar a los jóvenes en la elección de su futura carrera');
insert into kuder values(null, 'Diseñar motivos para nuevas telas');
insert into kuder values(null, 'Elaborar presupuestos de costos para impresión de libros y revistas');
insert into kuder values(null, 'Construir un telar de mano');
insert into kuder values(null, 'Hacer análisis estadísticos para predecir tendencias del mercado');
insert into kuder values(null, 'Hacer encuestas sobre la actitud de los jóvenes hacia la religión');
insert into kuder values(null, 'Modelar en yeso el rostro de un personaje célebre');
insert into kuder values(null, 'Escribir artículos sobre procedimientos para determinar el precio de venta de las mercancías');
insert into kuder values(null, 'Escribir un tema musical para un programa radial');
insert into kuder values(null, 'Trabajar como comprador de mercancías para una cooperativa');
insert into kuder values(null, 'Encargarse de la publicidad de una empresa importante');
insert into kuder values(null, 'Encargarse del mantenimiento de las máquinas de contabilidad en una empresa comercial');
insert into kuder values(null, 'Lograr que la gente lo trate a usted como a un amigo');
insert into kuder values(null, 'Lograr que la gente lo trate a usted como a un superior');
insert into kuder values(null, 'Lograr que nadie se fije en usted');
insert into kuder values(null, 'Ser profesor de música');
insert into kuder values(null, 'Ser diseñador de una casa de publicidad');
insert into kuder values(null, 'Investigar por que los chistes hacen reír');
insert into kuder values(null, 'Hacer las compras para una persona enferma');
insert into kuder values(null, 'Hacer un crucigrama para entretener a un enfermo');
insert into kuder values(null, 'Leer para distraer a una persona enferma');
-- kuder 9
insert into kuder values(null, 'Prestar primeros auxilios en un hospital');
insert into kuder values(null, 'Vender flores en una floristería');
insert into kuder values(null, 'Trabajar como secretario(a) privado(a)');
insert into kuder values(null, 'Redactar la página financiera en un periódico');
insert into kuder values(null, 'Cultivar una buena extensión de tierra');
insert into kuder values(null, 'Ser corredor de finca raíz');
insert into kuder values(null, 'Cuidar a sordomudos en un asilo');
insert into kuder values(null, 'Dibujar gráficas estadísticas');
insert into kuder values(null, 'Trabajar como dependiente en un almacén');
insert into kuder values(null, 'Ser escritor');
insert into kuder values(null, 'Ser autoridad en propaganda');
insert into kuder values(null, 'Ser religioso misionero');
insert into kuder values(null, 'Trabajar en lo que le agrada con un sueldo alto');
insert into kuder values(null, 'Trabajar en lo que le agrada con un sueldo bajo');
insert into kuder values(null, 'Trabajar en algo que no le agrada con un sueldo alto');
insert into kuder values(null, 'Enseñar a la gente pobre nociones de higiene');
insert into kuder values(null, 'Escribir artículos sobre temas de actualidad');
insert into kuder values(null, 'Vender objetos de arte');
insert into kuder values(null, 'Ser secretario(a) de un insigne líder político');
insert into kuder values(null, 'Enseñar a lo niños pintar y modelar');
insert into kuder values(null, 'Escribir artículos para una revista de arte');
insert into kuder values(null, 'Escoger su ropa siguiendo sus propios gustos');
insert into kuder values(null, 'Oír consejos en la elección de su ropa');
insert into kuder values(null, 'Dejar que otras personas la escojan para usted');
insert into kuder values(null, 'Diseñar proyectos para la construcción de puentes');
insert into kuder values(null, 'Trabajar en algo que requiere intenso cálculo mental');
insert into kuder values(null, 'Tener a su cargo la correspondencia de una oficina');
insert into kuder values(null, 'Dirigir la producción de tarjetas de Navidad');
insert into kuder values(null, 'Calcular el costo de producción de estas tarjetas');
insert into kuder values(null, 'Diseñar tarjetas de Navidad');
insert into kuder values(null, 'Examinar una cerradura dañada para ver como se arregla');
insert into kuder values(null, 'Corregir una prueba tipográfica');
insert into kuder values(null, 'Sumar una columna de cifras');
insert into kuder values(null, 'Tener entre sus amistades a una persona que siempre hace bromas a usted');
insert into kuder values(null, 'Hacer bromas a los otros');
insert into kuder values(null, 'No hacer bromas a nadie');
insert into kuder values(null, 'Ser psicólogo profesional');
insert into kuder values(null, 'Dirigir la construcción de puentes');
insert into kuder values(null, 'Ser arquitecto urbanista');
insert into kuder values(null, 'Investigar las causas de las enfermedades mentales');
insert into kuder values(null, 'Estudiar música');
insert into kuder values(null, 'Estudiar taquigrafía');
-- kuder 10
insert into kuder values(null, 'Trabajar como chofer de taxi');
insert into kuder values(null, 'Trabajar como celador en un faro marítimo');
insert into kuder values(null, 'Trabajar como guardián de un paso ferroviario');
insert into kuder values(null, 'Redactar avisos de propaganda');
insert into kuder values(null, 'Dirigir una biblioteca pública');
insert into kuder values(null, 'Editar un periódico');
insert into kuder values(null, 'Tomar clases de contabilidad de costos');
insert into kuder values(null, 'Tomar clases del arte de vender');
insert into kuder values(null, 'Tomar clases de correspondencia comercial');
insert into kuder values(null, 'Escribir una obra teatral');
insert into kuder values(null, 'Vender las boletas para una función teatral');
insert into kuder values(null, 'Manejar las fondos de una función teatral');
insert into kuder values(null, 'Hacer caricaturas de personajes célebres');
insert into kuder values(null, 'Pintar retratos de personajes célebres');
insert into kuder values(null, 'Pintar paisajes');
insert into kuder values(null, 'Dibujar ilustraciones para revistas');
insert into kuder values(null, 'Escribir artículos para revistas');
insert into kuder values(null, 'Ser agente distribuidor de una revista');
insert into kuder values(null, 'Pasar vacaciones en un elegante sitio de verano');
insert into kuder values(null, 'Pasarlas acampando fuera de la ciudad');
insert into kuder values(null, 'Pasarlas viajando por caminos apartados');
insert into kuder values(null, 'Vivir con un famoso crítico literario');
insert into kuder values(null, 'Vivir con un político destacado');
insert into kuder values(null, 'Vivir con un artista célebre');
insert into kuder values(null, 'Escribir artículos sobre pasatiempos');
insert into kuder values(null, 'Elaborar cuadros estadísticos sobre costos de vida');
insert into kuder values(null, 'Reparar y arreglar muebles viejos');
insert into kuder values(null, 'Revisar las pruebas tipográficas de libros para niños');
insert into kuder values(null, 'Contar cuentos a los niños');
insert into kuder values(null, 'Confeccionar juguetes a los niños');
insert into kuder values(null, 'Tomar clases de educación física');
insert into kuder values(null, 'Tomar clases de trabajos manuales');
insert into kuder values(null, 'Tomar clases de matemáticas');
insert into kuder values(null, 'Ser profesor de música');
insert into kuder values(null, 'Ser maestro de escuela');
insert into kuder values(null, 'Ser dentista');
insert into kuder values(null, 'Ser taquígrafo(a) de un tribunal');
insert into kuder values(null, 'Ser empresario de un célebre pianista');
insert into kuder values(null, 'Ser consejero vocacional');
insert into kuder values(null, 'Visitar un museo de ciencias naturales');
insert into kuder values(null, 'Visitar una fábrica de aviones');
insert into kuder values(null, 'Visitar los barrios bajos de una ciudad');
-- kuder 11
insert into kuder values(null, 'Hacer dibujos para revistas');
insert into kuder values(null, 'Criar ganado');
insert into kuder values(null, 'Cultivar frutos para la venta');
insert into kuder values(null, 'Trabajar como botones en un hotel');
insert into kuder values(null, 'Servir como mesero de restaurante');
insert into kuder values(null, 'Vivir en un sitio aislado atendiendo sus propias necesidades');
insert into kuder values(null, 'Ser guía de excursionistas');
insert into kuder values(null, 'Diseñar equipos para excursionistas');
insert into kuder values(null, 'Vender equipos para excursionistas');
insert into kuder values(null, 'Vender pólizas de seguro de vida');
insert into kuder values(null, 'Escribir artículos para una revista');
insert into kuder values(null, 'Trabajar como jardinero-decorador');
insert into kuder values(null, 'Ser considerado como modesto');
insert into kuder values(null, 'Ser considerado digno de confianza');
insert into kuder values(null, 'Ser considerado como poco serio');
insert into kuder values(null, 'Enseñar aritmética');
insert into kuder values(null, 'Adiestrar perros para los ciegos');
insert into kuder values(null, 'Ser secretario de un científico');
insert into kuder values(null, 'Tomar clases de música moderna');
insert into kuder values(null, 'Tomar clases de literatura moderna');
insert into kuder values(null, 'Tomar clases de pintura moderna');
insert into kuder values(null, 'Ser considerado como duro');
insert into kuder values(null, 'Ser considerado como justo');
insert into kuder values(null, 'Ser considerado como inteligente');
insert into kuder values(null, 'Ser director de orquesta');
insert into kuder values(null, 'Ser gerente de una empresa');
insert into kuder values(null, 'Ser director de un plan urbano');
insert into kuder values(null, 'Cultivar flores');
insert into kuder values(null, 'Manejar el mimeógrafo');
insert into kuder values(null, 'Llevar la contabilidad');
insert into kuder values(null, 'Trabajar como guía de turistas');
insert into kuder values(null, 'Tallar joyas finas');
insert into kuder values(null, 'Arreglar música para orquesta');
insert into kuder values(null, 'Trabajar como telefonista');
insert into kuder values(null, 'Diseñar “Ex - libris”');
insert into kuder values(null, 'Enseñar juegos a los niños');
insert into kuder values(null, 'Reparar un afecto eléctrico');
insert into kuder values(null, 'Ayudar a lavar platos');
insert into kuder values(null, 'Arreglar un cuarto desordenado');
insert into kuder values(null, 'Enseñar la construcción de muebles');
insert into kuder values(null, 'Corregir pruebas tipográficas');
insert into kuder values(null, 'Vender curiosidades de Oriente');
-- kuder 12
insert into kuder values(null, 'Ser secretario(a) privado(a)');
insert into kuder values(null, 'Ser contador(a)');
insert into kuder values(null, 'Ser vendedor(a)');
insert into kuder values(null, 'Practicar patinaje de figuras');
insert into kuder values(null, 'Jugar tenis');
insert into kuder values(null, 'Escalar montañas');
insert into kuder values(null, 'Trabajar en una oficina');
insert into kuder values(null, 'Trabajar en una hacienda');
insert into kuder values(null, 'Trabajar como vendedor de casa en casa');
insert into kuder values(null, 'Trabajar en una fábrica de dulces');
insert into kuder values(null, 'Explotar un colmenar');
insert into kuder values(null, 'Ser optometrista');
insert into kuder values(null, 'Ser agricultor');
insert into kuder values(null, 'Ser conductor de tren');
insert into kuder values(null, 'Ser oficinista');
insert into kuder values(null, 'Hacer trabajos de oficina');
insert into kuder values(null, 'Enseñar literatura');
insert into kuder values(null, 'Vender objetos de arte');
insert into kuder values(null, 'Estudiar contabilidad');
insert into kuder values(null, 'Estudiar métodos en irrigación');
insert into kuder values(null, 'Estudiar taquigrafía');
insert into kuder values(null, 'Repartir el correo');
insert into kuder values(null, 'Trabajar en el aseo público');
insert into kuder values(null, 'Clasificar correo en una oficina postal');
insert into kuder values(null, 'Ser poeta');
insert into kuder values(null, 'Ser artista');
insert into kuder values(null, 'Trabajar en la asistencia social');
insert into kuder values(null, 'Resolver rompecabezas');
insert into kuder values(null, 'Jugar a las damas');
insert into kuder values(null, 'Resolver rompecabezas mecánicos');
insert into kuder values(null, 'Fundar un periódico');
insert into kuder values(null, 'Fundar una escuela de arte');
insert into kuder values(null, 'Fundar una orquesta');
insert into kuder values(null, 'Tener amigos');
insert into kuder values(null, 'Tener poder');
insert into kuder values(null, 'Tener fama');
insert into kuder values(null, 'Ser mecánico');
insert into kuder values(null, 'Ser arquitecto');
insert into kuder values(null, 'Ser químico');
insert into kuder values(null, 'Empastar libros');
insert into kuder values(null, 'Cuidar niños enfermos');
insert into kuder values(null, 'Copiar cartas en maquina');
