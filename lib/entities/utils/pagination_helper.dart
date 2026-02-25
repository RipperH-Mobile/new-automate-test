int getOffsetFromLimitAndPage(int limit, int page) {
  if (page < 1) {
    return 0;
  }

  return limit * (page - 1);
}
