CREATE DATABASE enpro DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
use enpro;
create table chaside(
  id integer not null auto_increment,
  preg varchar(256),
  primary key(id)
);
create table reschaside(
  id integer not null auto_increment,
  letra char(1),
  nombre varchar(128),
  intereses varchar(256),
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
  reschaside_id integer null,
  primary key(id),
  foreign key(reschaside_id)
  references reschaside(id)
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

insert into reschaside values(null, 'C', 'Administrativas y Contables',
'Organización,Supervisión,Orden,Análisis y síntesis,Colaboración,Cálculo',
'Persuasivo,Objetivo,Práctico,Tolerante,Responsable,Ambicioso');
insert into reschaside values(null, 'H', 'Humanísticas y Sociales',
'Precisión Verbal,Organización,Relación de Hechos,Lingüística,Orden,Justicia',
'Responsable,Justo,Conciliador,Persuasivo,Sagaz,Imaginativo');
insert into reschaside values(null, 'A', 'Artísticas',
'Estética,Lo Armónico,Lo Manual,Lo Visual,Lo Auditivo',
'Sensible,Imaginativo,Creativo,Detallista,Innovador,Intuitivo');
insert into reschaside values(null, 'S', 'Medicina y Ciencias de la Salud',
'Asistir,Investigar,Precisión,Analítico,Ayudar',
'Altruista,Solidario,Paciente,Comprensivo,Respetuoso,Persuasivo');
insert into reschaside values(null, 'I', 'Ingeniería y Computación',
'Cálculo,Científico,Manual,Exacto,Planificar',
'Preciso,Práctico,Crítico,Analítico,Rígido');
insert into reschaside values(null, 'D', 'Defensa y Seguridad',
'Justicia,Equidad,Colaboración,Espíritu de Equipo,Liderazgo',
'Arriesgado,Solidario,Valiente,Agresivo,Persuasivo');
insert into reschaside values(null, 'E', 'Ciencias Exactas y Agrarias',
'Investigación,Orden,Organización,Análisis y Síntesis,Numérico,Clasificar',
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
