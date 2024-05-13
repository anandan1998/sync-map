// model.dart
//This is the data model for the map coloring, Name is the region name and the density is the value to be used(generally the number of cases in the region in a time period.)

class Model {
  const Model(this.name, this.density);

  final String name;
  final double density;
}