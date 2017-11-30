import CalendarKit

struct StyleGenerator {
  static func defaultStyle() -> CalendarStyle {
    return CalendarStyle()
  }

  static func darkStyle() -> CalendarStyle {
    let orange = UIColor.orange
    let dark = UIColor(white: 0.1, alpha: 1)
    let light = UIColor.lightGray
    let white = UIColor.white

    let selector = DaySelectorStyle(activeTextColor: white,
                                    selectedBackgroundColor: light,
                                    inactiveTextColor: white,
                                    todayInactiveTextColor: orange,
                                    todayActiveBackgroundColor: orange)

    let daySymbols = DaySymbolsStyle(weekendColor: light, weekDayColor: white)

    let swipeLabel = SwipeLabelStyle(textColor: white)

    let header = DayHeaderStyle(daySymbols: daySymbols,
                                daySelector: selector,
                                swipeLabel: swipeLabel,
                                backgroundColor: dark)

    let timeIndicator = CurrentTimeIndicatorStyle(color: orange)
    let timeline = TimelineStyle(timeIndicator: timeIndicator,
                                 timeColor: light,
                                 lineColor: light,
                                 backgroundColor: dark)

    let style = CalendarStyle(header: header, timeline: timeline)

    return style
  }
}
