void addIfNonNull<T>(T widget, List<T> children) {
  if (widget != null) {
    children.add(widget);
  }
}
