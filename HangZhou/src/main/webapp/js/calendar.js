function Calendar(el) {
  var week = ['一','二','三','四','五','六','日'];
  if (typeof(el)=='string') { el = $('#'+el); }
  if (typeof(el)!='object') { return false; }
  el[0].innerHTML = '<div class="header"><div class="lb" id="lbtn"><i class="icon-angle-left"></i></div><div class="rb" id="rbtn"><i class=" icon-angle-right"></i></div><div id="date"></div></div><table class="calendar"><thead><tr><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tr></thead><tbody><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr><tr><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th><th class="day"></th></tr></tbody></table>';
  var theads = el.find('thead th');
  if (theads.length != 7) { return false; }
  theads.each(function(index,item) {
    item.innerHTML = week[index];
  });
  window.calendarDate = new Date();
  showCalendar(calendarDate);
  $('#lbtn').click(function() {
    var m = calendarDate.getMonth();
    if (m > 0) {
      calendarDate.setMonth(--m);
    } else {
      calendarDate.setFullYear(calendarDate.getFullYear() - 1);
      calendarDate.setMonth(11);
    }
    showCalendar(calendarDate);
  });
  $('#rbtn').click(function() {
    var m = calendarDate.getMonth();
    calendarDate.setMonth(++m);
    showCalendar(calendarDate);
  });
};
function addEventList(list) {
  window.elist = list;
  showCalendar(calendarDate);
};
//日历上的事件响应
function addEvent() {
  if (typeof(elist) != 'object'||!Array.isArray(elist)) { return; }
  window.elistdays = [];
  elist.forEach(function(item, index, array) {
    var edate = new Date(item.time);
    if (edate.getFullYear() == calendarDate.getFullYear() && edate.getMonth() == calendarDate.getMonth()) {
      elistdays.push(edate.getDate());
      $('.day').each(function(index,ditem) {
        if (ditem.getAttribute('data-key') == edate.getDate()) {
          var cname = ditem.className;
          if(cname.indexOf('event') == -1) {
            ditem.className = cname + ' event';
             var tip = document.createElement('div');
             var ico = document.createElement('i');
             ico.className = 'icon-star';
             tip.className = 'tip-box';
             ditem.appendChild(ico);
             ditem.appendChild(tip);
          }
           var tip = ditem.querySelector('.tip-box');
           var tiplist = document.createElement('p');
           tiplist.innerHTML = "<a href='"+item.href+"'>"+item.desc+"</a>";
           tip.appendChild(tiplist);
           var eid = ditem.getAttribute('data-id');
          if (eid == null) {
            eid = item.id;
//            ditem.setAttribute('data-trigger','modal');
//            ditem.setAttribute('href','test.html')
          }else { eid += ','+item.id; }
          ditem.setAttribute('data-id', eid);
        };
      });
    }
  });
   $('#calendar .event').click(function() {
     var ecname = this.className;
     if (ecname.indexOf('on') == -1) {
       this.className = ecname + ' on';
     }else {
       this.className = ecname.substr(0,ecname.indexOf('on')-1);
     }
   });
};
function showCalendar(date) {
  if (date == undefined) { date = new Date(); }
  var strTime = date.getFullYear() + '年' + (date.getMonth()+1) + '月';
  $('#date')[0].innerHTML = strTime;
  date.setDate(1);
  var starWeek= date.getDay()-1;
  if (starWeek == -1) { starWeek = 6; }
  var dayNum = getDayNum(date);
  var lastDayNum = getDayNum(date, true);
  showCalendardays(starWeek, dayNum, lastDayNum);
  addEvent();
};
function getDayNum(date,flag) {
  if (date == undefined) { date = new Date(); }
  var dayNum = [31,28,31,30,31,30,31,31,30,31,30,31];
  var month = date.getMonth();
  if (flag == true) {
    month -= 1;
    if (month == -1) { month = 11; }
  }
  if (month != 1) { return dayNum[month]; }
  var tdate = new Date(date.getFullYear(),1);
  tdate.setDate(29);
  if (tdate.getMonth() == 1) { return 29; }
  else {
    return 28;
  }
};
function showCalendardays(starWeek, dayNum, lastDayNum) {
  var days = $('.day');
  days.unbind('click');
  days.each(function(index,item) {
    item.className = 'day';
    index = index - starWeek + 1;
    if (index > dayNum) {
      index -= dayNum;
      item.className = 'day after';
    }else if (index < 1 ) {
      index += lastDayNum;
      item.className = 'day before';
    }else {
      item.setAttribute('data-key',index);
      item.setAttribute('data-id',"");
    }
    item.innerHTML = index;
  });
  $('tbody tr').each(function() {
    if (this.getElementsByClassName('after').length == 7) {
      this.style.display = 'none';
    }else {
      this.style.display = '';
    }
  });
};