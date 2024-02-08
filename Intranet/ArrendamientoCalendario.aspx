<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="ArrendamientoCalendario.aspx.vb" Inherits="Intranet.ArrendamientoCalendario" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .fc-unthemed .fc-today{
            background: #f3f3f3;
        }
        .fc-time-grid .fc-event{
             border: solid 1px #777;
        }
        /*.qtip-default{*/
            /*border: 1px solid #dddddd;*/
            /*background-color: #fdfdfd;*/
        /*}*/

        .fc-day-grid-event > .fc-content {
            white-space: normal !important;
        }
        .fc-day-grid-event .fc-time{
           display : none;
        }
    </style>

    <link rel="stylesheet" type="text/css" href="/fullcalendar/fullcalendar.css" />
    <script type="text/javascript" src="/fullcalendar/moment.js"></script>
    <script type="text/javascript" src="/fullcalendar/fullcalendar.min.js"></script>
    <script type="text/javascript" src="/fullcalendar/lang/es.js"></script>
    <script type="text/javascript" src="/fullcalendar/fullcalendar.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  







<div class="content-wrap">
    <div class="wrapper no-p" style="background-color: #eee; padding-left: 10px; padding-right: 10px; padding-top: 10px;">
        <div id="calendar"></div>
    </div>
</div>




















    <script type="text/javascript">
        var fullcalendar = function () {

            var colorClass;

            function events() {
                $(document).on("click", ".event-color > li > a", function (e) {
                    e.preventDefault();
                    e.stopPropagation();

                    colorClass = $(this).data("class");

                    $("#event-color-btn").removeClass().addClass("text-" + colorClass);
                });

                $(document).on("click", ".add-event", function (e) {

                    if (typeof colorClass === 'undefined') {
                        colorClass = "color";
                    }

                    var newEvent = $(".new-event").val(),
                        markup = $("<div class=\"external-event label label-" + colorClass + "\" data-class=\"bg-" + colorClass + "\">" + newEvent + "</div>");

                    if (newEvent !== "") {
                        $(".external-events").append(markup);

                        externalEvents(markup);

                        $(".new-event").val("");
                    }

                    e.preventDefault();
                    e.stopPropagation();
                });
            }

            function buttons() {

                $("#calendar-day > span").html($(".fc-agendaDay-button").html());

                $("#calendar-week > span").html($(".fc-agendaWeek-button").html());

                $("#calendar-month > span").html($(".fc-month-button").html());

                $("#calendar-today").html($(".fc-today-button").html());

                $("#calendar-prev").html($(".fc-prev-button").html());

                $("#calendar-next").html($(".fc-next-button").html());

                $(document).on("click", "#calendar-list", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('changeView', 'basicDay');
                });

                $(document).on("click", "#calendar-day", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('changeView', 'basicDay');
                });

                $(document).on("click", "#calendar-week", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('changeView', 'basicWeek');
                });

                $(document).on("click", "#calendar-month", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('changeView', 'month');
                });

                $(document).on("click", "#calendar-today", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('today');
                    updateDate();
                });

                $(document).on("click", "#calendar-prev", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('prev');
                    updateDate();
                });

                $(document).on("click", "#calendar-next", function (e) {
                    e.preventDefault();
                    $('#calendar').fullCalendar('next');
                    updateDate();
                });


            }

            function updateDate() {
                var moment = $('#calendar').fullCalendar('getDate');
                $(".week-day").html(moment.format("dddd"));
                $(".current-date").html(moment.format("MMM Do [<b>] YYYY [</b>]"));
            }

            function externalEvents(elm) {
                // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
                // it doesn't need to have a start or end
                var eventObject = {
                    title: $.trim(elm.text()), // use the element's text as the event title
                    className: elm.data("class")
                };

                // store the Event Object in the DOM element so we can get to it later
                elm.data('eventObject', eventObject);

                // make the event draggable using jQuery UI
                elm.draggable({
                    zIndex: 999,
                    revert: true, // will cause the event to go back to its
                    revertDuration: 0 //  original position after the drag
                });
            }

            // initialize the external events
            function initCalendarEvents() {
                $('#external-events div.external-event').each(function () {
                    externalEvents($(this));
                });
            }

            // initialize the calendar
            function initCalendar() {

                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next',
                        center: 'title',
                        right: 'today,month,basicWeek,basicDay'
                    },
                    //buttonIcons: {
                    //    prev: ' ti-arrow-circle-left',
                    //    next: ' ti-arrow-circle-right'
                    //},
                    buttonText: {
                        prev: 'Previous',
                        next: 'Next'
                    },
                    minTime: '05:00',
                    scrollTime: '08:00',
                    contentHeight: 700,
                    allDaySlot: false,
                    businessHours: {
                        start: '09:00', // a start time (10am in this example)
                        end: '18:00', // an end time (6pm in this example)

                        dow: [1, 2, 3, 4, 5]
                    },
                    editable: false,
                    eventDurationEditable: false,
                    droppable: false,
                    drop: function (date) {
                        var originalEventObject = $(this).data('eventObject');
                        var copiedEventObject = $.extend({}, originalEventObject);
                        copiedEventObject.start = date;
                        $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
                        if ($('#drop-remove').is(':checked')) {
                            $(this).remove();
                        }
                    },
                    defaultView: 'month',
                    events: {
                        url: '/ArrendamientoCalendarioConsulta.aspx',
                        type: 'POST',
                        error: function () {
                            console.log('there was an error while fetching events!');
                        }
                    },
                    eventRender: function (event, element) {
                        //element.find('.fc-title').append(" <a href='/ArrendamientoDetalle.aspx?id=" + event.id + "' style='color:#fff' target='_blank'>(Ver)</a>");

                    },
                    eventClick: function (data, event, view) {
                        //MuestraDetalle(data.cita_id);                        
                    },
                    eventDrop: function (event, delta, revertFunc) {
                    },
                    timeFormat: 'h(:mm)t'
                });
            }

            return {
                init: function () {
                    events();
                    initCalendarEvents();
                    initCalendar();
                    buttons();
                    updateDate();
                }
            };
        }();

        $(function () {
            "use strict";
            fullcalendar.init();
        });


    </script>
</asp:Content>
