String greeting() {
  var time = DateTime.now().hour;
  if (time < 12) {
    return 'Good morning';
  } else if (time < 18) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
