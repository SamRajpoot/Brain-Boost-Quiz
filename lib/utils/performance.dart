String performanceLabel(int score) {
  if (score <= 3) {
    return 'Beginner';
  }
  if (score <= 7) {
    return 'Intermediate';
  }
  return 'Expert';
}
