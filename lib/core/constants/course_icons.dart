enum CourseIcons {
  atom(path: 'assets/images/icons/atom.svg', name: 'atom', label: 'Física'),
  brain(
    path: 'assets/images/icons/brain.svg',
    name: 'brain',
    label: 'Psicología',
  ),
  briefcase(
    path: 'assets/images/icons/briefcase.svg',
    name: 'briefcase',
    label: 'Administración',
  ),
  calculator(
    path: 'assets/images/icons/calculator.svg',
    name: 'calculator',
    label: 'Matemáticas',
  ),
  chartLine(
    path: 'assets/images/icons/chart-line.svg',
    name: 'chart-line',
    label: 'Estadística',
  ),
  code(
    path: 'assets/images/icons/code.svg',
    name: 'code',
    label: 'Programación',
  ),
  database(
    path: 'assets/images/icons/database.svg',
    name: 'database',
    label: 'Base de Datos',
  ),
  earthAmericas(
    path: 'assets/images/icons/earth-americas.svg',
    name: 'earth-americas',
    label: 'Geografía',
  ),
  fileInvoice(
    path: 'assets/images/icons/file-invoice.svg',
    name: 'file-invoice',
    label: 'Contabilidad',
  ),
  flask(path: 'assets/images/icons/flask.svg', name: 'flask', label: 'Química'),
  gavel(path: 'assets/images/icons/gavel.svg', name: 'gavel', label: 'Derecho'),
  gears(
    path: 'assets/images/icons/gears.svg',
    name: 'gears',
    label: 'Ingeniería',
  ),
  language(
    path: 'assets/images/icons/language.svg',
    name: 'language',
    label: 'Idiomas',
  ),
  laptopCode(
    path: 'assets/images/icons/laptop-code.svg',
    name: 'laptop-code',
    label: 'Informática',
  ),
  masksTheater(
    path: 'assets/images/icons/masks-theater.svg',
    name: 'masks-theater',
    label: 'Artes',
  ),
  microchip(
    path: 'assets/images/icons/microchip.svg',
    name: 'microchip',
    label: 'Electrónica',
  ),
  network(
    path: 'assets/images/icons/network.svg',
    name: 'network',
    label: 'Redes',
  ),
  palette(
    path: 'assets/images/icons/palette.svg',
    name: 'palette',
    label: 'Diseño',
  ),
  personChalkboard(
    path: 'assets/images/icons/person-chalkboard.svg',
    name: 'person-chalkboard',
    label: 'Pedagogía',
  ),
  shapesSolid(
    path: 'assets/images/icons/shapes-solid.svg',
    name: 'shapes-solid',
    label: 'Geometría',
  ),
  stethoscope(
    path: 'assets/images/icons/stethoscope.svg',
    name: 'stethoscope',
    label: 'Salud',
  ),
  userGroup(
    path: 'assets/images/icons/user-group.svg',
    name: 'user-group',
    label: 'Sociología',
  ),
  utensils(
    path: 'assets/images/icons/utensils.svg',
    name: 'utensils',
    label: 'Gastronomía',
  ),
  wheatAwn(
    path: 'assets/images/icons/wheat-awn.svg',
    name: 'wheat-awn',
    label: 'Biología',
  );

  final String path;
  final String name;
  final String label;

  const CourseIcons({
    required this.path,
    required this.name,
    required this.label,
  });

  static CourseIcons? fromName(String name) {
    try {
      return CourseIcons.values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }

  static String getPath(String name) {
    return CourseIcons.values.firstWhere((e) => e.name == name).path;
  }
}
