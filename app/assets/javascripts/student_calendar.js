$(document).ready(function () {
    $.ajax({
        type: 'GET',
        url: '/periods_json_for_students/',
        success: function(data){
            $('#calendar').fullCalendar({
                events: data,

                eventClick: function(Event, element, view) {
                    if(Event.attribute == "calendar_event") {
                        $.ajax({
                            type: 'GET',
                            data: {
                                'event_id': Event.id
                            },
                            url: '/get_event_for_popup/',
                            success: function(data){
                                $('#event-popup').html(data);
                                $('.first.modal').modal({duration: 100}).modal('show')
                            }
                        });
                    }
                    else {
                        $.ajax({
                            type: 'GET',
                            data: {
                                'period_id': Event.id
                            },
                            url: '/get_period_for_popup/',
                            success: function(data) {
                                $('#period-popup').html(data);
                                $('.first.modal').modal({duration: 100}).modal('show')
                            }
                        });
                    }
                },

                axisFormat: 'HH:mm',
                timeFormat: 'H:mm',
                minTime: '09:00:00',
                maxTime: '22:00:00',

                selectable: true,
                selectHelper: true,
                defaultView: "agendaWeek",
                firstDay: 1,
                displayEventEnd: true,
                eventColor: 'lightgray',
                eventTextColor: 'black',
                height: 600,

                header: {
                    left: "prev,next today",
                    center: "title",
                    right: "month,agendaWeek,agendaDay"
                },

                monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                monthNamesShort: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
                dayNamesShort: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],

                buttonText: {
                    today: "Сегодня",
                    month: "Месяц",
                    week: "Неделя",
                    day: "День"
                }

            });
        }
    });
});