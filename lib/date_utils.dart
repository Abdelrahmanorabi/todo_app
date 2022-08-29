// to get only date from Datetime [year-month-day] and ignore time [hour-sec-,millsec]
DateTime dateOnly(DateTime inputDateTime) {
  return DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);
}
