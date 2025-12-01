enum CourseIcons {
  atom(path: 'assets/images/icons/atom.svg', label: 'Física'),
  brain(path: 'assets/images/icons/brain.svg', label: 'Psicología'),
  briefcase(path: 'assets/images/icons/briefcase.svg', label: 'Administración'),
  calculator(path: 'assets/images/icons/calculator.svg', label: 'Matemáticas'),
  chartLine(path: 'assets/images/icons/chart-line.svg', label: 'Estadística'),
  code(path: 'assets/images/icons/code.svg', label: 'Programación'),
  database(path: 'assets/images/icons/database.svg', label: 'Base de Datos'),
  earthAmericas(
    path: 'assets/images/icons/earth-americas.svg',
    label: 'Geografía',
  ),
  fileInvoice(
    path: 'assets/images/icons/file-invoice.svg',
    label: 'Contabilidad',
  ),
  flask(path: 'assets/images/icons/flask.svg', label: 'Química'),
  gavel(path: 'assets/images/icons/gavel.svg', label: 'Derecho'),
  gears(path: 'assets/images/icons/gears.svg', label: 'Ingeniería'),
  language(path: 'assets/images/icons/language.svg', label: 'Idiomas'),
  laptopCode(path: 'assets/images/icons/laptop-code.svg', label: 'Informática'),
  masksTheater(path: 'assets/images/icons/masks-theater.svg', label: 'Artes'),
  microchip(path: 'assets/images/icons/microchip.svg', label: 'Electrónica'),
  network(path: 'assets/images/icons/network.svg', label: 'Redes'),
  palette(path: 'assets/images/icons/palette.svg', label: 'Diseño'),
  personChalkboard(
    path: 'assets/images/icons/person-chalkboard.svg',
    label: 'Pedagogía',
  ),
  shapesSolid(path: 'assets/images/icons/shapes-solid.svg', label: 'Geometría'),
  stethoscope(path: 'assets/images/icons/stethoscope.svg', label: 'Salud'),
  userGroup(path: 'assets/images/icons/user-group.svg', label: 'Sociología'),
  utensils(path: 'assets/images/icons/utensils.svg', label: 'Gastronomía'),
  wheatAwn(path: 'assets/images/icons/wheat-awn.svg', label: 'Biología');

  final String path;
  final String label;

  const CourseIcons({required this.path, required this.label});

  static CourseIcons? fromName(String name) {
    try {
      return CourseIcons.values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }
}
