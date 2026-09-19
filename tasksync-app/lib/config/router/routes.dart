enum AppRoutes {
  login('/login'),
  register('/register'),
  home('/home'),
  addTask('/add-task'),
  editTask('/edit-task/:id'),
  viewTask('/view-task/:id');

  final String path;
  const AppRoutes(this.path);
}
