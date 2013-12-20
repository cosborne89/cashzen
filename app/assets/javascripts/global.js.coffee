$(document).on 'ready page:change', -> $('.datepicker').datepicker({
    dateFormat: 'mm/dd/yy',
    altFormat: 'dd/mm/yy',
    changeMonth: true,
    changeYear: true,
    yearRange: '-5:+5'
});