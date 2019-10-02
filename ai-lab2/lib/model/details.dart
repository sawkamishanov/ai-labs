
class Details {
  var time;
  int depth;
  int countNodes;
  double memory;
  int func;
  int heuristic;

  Details() {
    initDetails();
  }

  initDetails() {
    time = 0;
    depth = 0;
    countNodes = 0;
    memory = 0.0;
    func = 0;
    heuristic = 0;
  }
}