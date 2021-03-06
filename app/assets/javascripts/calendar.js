$(document).ready(function () {
    $('.ui.accordion').accordion();
    $.ajax({
        type: 'GET',
        url: '/periods_json/',
        success: function(data){
            $('#calendar').fullCalendar({

                events: data,

                editable: true,
                eventDrop: function(event, delta, revertFunc) {
                    if (!confirm('Занятие ' + event.title + ' будет перенесено на дату ' +
                            event.start.format() + '.' + ' Сохранить изменения?')) {
                        revertFunc();
                    }
                },

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
                                $('.coupled.modal').modal({allowMultiple: false});
                                $('.first.modal').modal({duration: 100}).modal('show')
                                $('.second.modal').modal('attach events', '.first.modal #edit_button')
                                $.ajax({
                                    type: 'GET',
                                    url: '/admin/events/' + Event.id + '/edit/',
                                    success: function(data){
                                        $('.edit_event_from_calendar_form').html(data)
                                        $('.dropdown').dropdown();
                                    }
                                })
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
                                $('.coupled.modal').modal({allowMultiple: false});
                                $('.first.modal').modal({duration: 100}).modal('show')
                                $('.second.modal').modal('attach events', '.first.modal #edit_button')
                                $.ajax({
                                    type: 'GET',
                                    url: '/edit_period_from_calendar/' + Event.id,
                                    success: function(data){
                                        $('.edit_period_from_calendar_form').html(data)
                                        $('.dropdown').dropdown();
                                    }
                                })
                            }
                        });
                    }
                },
                dayClick: function(date, jsEvent, view) {
                    //Resets form input fields
                    $('.ui.form').trigger("reset");
                    //Resets form error messages
                    $('.ui.form .field.error').removeClass( "error" );
                    $('.ui.form.error').removeClass( "error" );
                    $('.ui.modal').modal('show').modal({
                            onApprove : function() {
                                //Submits the semantic ui form
                                //And pass the handling responsibilities to the form handlers, e.g. on form validation success
                                $('.ui.form').submit();
                                //Return false as to not close modal dialog
                                return false;
                            },
                        });
                    $('.ui.form').form({
                        fields: {
                            'period[title]': {
                                identifier : 'period[title]',
                                rules: [
                                    {
                                        type   : 'empty',
                                        prompt : 'Поле не может быть пустым'
                                    }
                                ]
                            },
                            'period[course_id]': {
                                identifier : 'period[course_id]',
                                rules: [
                                    {
                                        type   : 'empty',
                                        prompt : 'Курс не может быть пустым'
                                    }
                                ]
                            },
                            'period[group_id]': {
                                identifier : 'period[group_id]',
                                rules: [
                                    {
                                        type   : 'empty',
                                        prompt : 'Поле не может быть пустым'
                                    }
                                ]
                            },
                        },
                        inline : true,
                        on     : 'blur',
                        onSuccess : function()
                        {
                            //Hides modal on validation success
                            $('.ui.modal').modal('hide');
                        },
                    });

                    $('.menu .item').tab();
                    date = date.format();
                    var date_array = date.split("-");
                    var day =  parseInt(date_array[2]);
                    var month = parseInt(date_array[1]);
                    var year = parseInt(date_array[0]);
                    if(view.name == 'agendaWeek'){
                        var full_time = date.split("T");
                        var time_array = full_time[1].split(":");
                        var hour = time_array[0];
                        var minute = parseInt(time_array[1]);
                        if(minute == 0){ minute = '00'}
                    }
                    else{
                        hour = 19;
                        minute = '00';
                    }
                    var selectedday =  day + '/' + month + '/' + year;
                    $("#period_commence_datetime").val(selectedday);
                    $("#period_start_time_4i").val(hour);
                    $("#period_start_time_5i").val(minute);
                    $("#period_start_time_4i").siblings(".text").text(hour);
                    $("#period_start_time_5i").siblings(".text").text(minute);
                    $("#period_end_time_4i").val(parseInt(hour) + 2);
                    $("#period_end_time_5i").val(minute);
                    $("#period_end_time_4i").siblings(".text").text(parseInt(hour) + 2);
                    $("#period_end_time_5i").siblings(".text").text(minute);
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
                    right: "month,agendaWeek"
                },

                monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                monthNamesShort: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
                dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
                dayNamesShort: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],

                buttonText: {
                    today: "Сегодня",
                    month: "Месяц",
                    week: "Неделя"
                }

            });
        }
    });

    $('#courses_list').change(function(){
        var selected_courses = $("#courses_list input[type=checkbox]:checked").map(function(){
            return $(this).val()
        }).get();
        $.ajax({
            type: 'GET',
            url: '/groups_of_courses/',
            data: {
                "course_id": selected_courses
            },
            success: function(data){
                $(".ui.checkbox").checkbox();
                $('.groups_of_courses').html(data);
            }
        });

        $.ajax({
            type: 'GET',
            url: '/teachers_of_courses/',
            data: {
                'course_id': selected_courses
            },
            success: function(data){
                $('.teachers_of_courses').html(data);
                $(".ui.checkbox").checkbox();
            }
        });

        $.ajax({
            type: 'GET',
            url: '/filter_periods_by_course/',
            data: {
                "course_id": selected_courses
            },
            success: function(data){
                $('#calendar').fullCalendar('removeEvents');
                $("#calendar").fullCalendar("addEventSource", data)
            }
        })
    });

    $('#groups_list').change(function(){
        var selected_groups = $("#groups_list input[type=checkbox]:checked").map(function(){
            return $(this).val()
        }).get();

        $.ajax({
            type: 'GET',
            url: '/teacher_of_group/',
            data: {
                'group_id': selected_groups
            },
            success: function(data){
                $('.teachers_of_courses').html(data);
                $('.ui.checkbox').checkbox()
            }
        })

        $.ajax({
            type: 'GET',
            url: '/filter_periods_by_group/',
            data: {
                "group_id": selected_groups
            },
            success: function(data){
                $('#calendar').fullCalendar('removeEvents');
                $("#calendar").fullCalendar("addEventSource", data)
            }
        })
    });

    $('#teachers_list').change(function(){
        var selected_teachers = $('#teachers_list input[type=checkbox]:checked').map(function(){
            return $(this).val()
        }).get();

        $.ajax({
            type: 'GET',
            url: '/filter_periods_by_teachers/',
            data: {
                'teacher_id': selected_teachers
            },
            success: function(data){
                $('#calendar').fullCalendar('removeEvents');
                $("#calendar").fullCalendar("addEventSource", data)
            }
        })
    })

    $("#course_of_period").on("change", function() {
        var selected_course = $(this).val();
        $.ajax({
            type: "GET",
            data: {
                "course_id": selected_course
            },
            url: '/groups_of_course/',
            success: function(data) {
                var GroupSelection = $("#groups_of_selected_courses");
                GroupSelection.empty();
                for (var i = 0; i < data.length; i++) {
                    GroupSelection.append("<option value=''></option>");
                    GroupSelection.append("<option value='" + data[i].id + "'>" + data[i].name + "</option>")
                }
            }
        })

        $.ajax({
            type: "GET",
            data: {
                "course_id": selected_course
            },
            url: '/course_elements_of_course/',
            success: function(data) {
                var CourseElementSelection = $("#course_elements_of_selected_courses");
                CourseElementSelection.empty();
                for (var i = 0; i < data.length; i++) {
                    CourseElementSelection.append("<option value=''></option>");
                    CourseElementSelection.append("<option value='" + data[i].id + "'>" + data[i].theme + "</option>")
                }
            }
        })
    });
});