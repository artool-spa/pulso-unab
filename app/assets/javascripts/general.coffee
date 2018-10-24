# Calendar
init_calendar_handler1 = ->
  filter_days = if filter_from? then moment(filter_from).diff(moment(), 'days') else 0
  formatString = "YYYY-MM-DD"
  optionSet1 =
    #dateLimit: days: filter_days
    autoUpdateInput: true
    alwaysShowCalendars: true
    autoApply: true
    showDropdowns: true
    showWeekNumbers: true
    timePicker: false
    timePicker12Hour: true
    maxDate: moment().subtract(1, 'days')
    ranges:
      'Hoy': [
        moment().startOf('day')
        moment().startOf('day')
      ]
      'Ayer': [
        moment().subtract(1, 'days').startOf('day')
        moment().subtract(1, 'days').startOf('day')
      ]
    opens: 'left'
    buttonClasses: 'btn btn-default'
    applyClass: 'btn-sm btn-primary'
    cancelClass: 'btn btn-default'
    separator: ' - '
    locale:
      format: formatString
      applyLabel: 'Aplicar'
      cancelLabel: 'Cerrar'
      fromLabel: 'Desde'
      toLabel: 'Hasta'
      customRangeLabel: 'Definir Rango'
      daysOfWeek: [
        'Do'
        'Lu'
        'Ma'
        'Mi'
        'Ju'
        'Vi'
        'Sa'
      ]
      monthNames: [
        'Enero'
        'Febrero'
        'Marzo'
        'Abril'
        'Mayo'
        'Junio'
        'Julio'
        'Agosto'
        'Septiembre'
        'Octubre'
        'Noviembre'
        'Diciembre'
      ]
      firstDay: 1

  optionSet1['ranges']['Últimos 7 Días']  = [moment().subtract(6, 'days'), moment()]              if filter_days >= 7 || filter_days == 0
  optionSet1['ranges']['Últimos 15 Días'] = [moment().subtract(14, 'days'), moment()]             if filter_days >= 14 || filter_days == 0
  optionSet1['ranges']['Mes Pasado']      = [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]  if filter_days >= 60 || filter_days == 0
  optionSet1['ranges']['Mes en Curso']    = [moment().startOf('month'), moment().subtract(1, 'days')]                 if filter_days >= 30 || filter_days == 0
  optionSet1['ranges']['Año en Curso']    = [moment().startOf('year'), moment()]                  if filter_days >= 365 || filter_days == 0

  formatCallback1 = (start, end) ->
    $(".daterange").val(start.format(formatString) + ' - ' + end.format(formatString))

  $("input.daterange").daterangepicker optionSet1, formatCallback1
  return

# Initialize autoNumeric for .input-money1 inputs
init_autonumeric = ->
  AutoNumeric.multiple('.input-money1',
    allowDecimalPadding: false
    currencySymbol: '$'
    decimalCharacter: ','
    digitGroupSeparator: '.'
    showWarnings: false)
  return

# Initialize bootstrapSortable turbolinks compatible resorter
bootstrap_sortable_resort = ->
  $.bootstrapSortable()
  return

$(document).on "turbolinks:load", ->
  init_calendar_handler1()
  init_autonumeric()
  bootstrap_sortable_resort()

  $(".selectpicker").selectpicker()

  #$('.multiselect1').multiSelect()
  $('.multiselect1').multiSelect(
    selectableHeader: '<input type=\'text\' class=\'form-control search-input \' autocomplete=\'off\' placeholder=\'Buscar Cliente\'>'
    selectionHeader: '<input type=\'text\' class=\'form-control search-input\' autocomplete=\'off\' placeholder=\'Buscar Cliente\'>'
    afterInit: (ms) ->
      that = this
      $selectableSearch = that.$selectableUl.prev()
      $selectionSearch = that.$selectionUl.prev()
      selectableSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selectable:not(.ms-selected)'
      selectionSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selection.ms-selected'
      that.qs1 = $selectableSearch.quicksearch(selectableSearchString).on('keydown', (e) ->
        if e.which == 40
          that.$selectableUl.focus()
          return false
        return
      )
      that.qs2 = $selectionSearch.quicksearch(selectionSearchString).on('keydown', (e) ->
        if e.which == 40
          that.$selectionUl.focus()
          return false
        return
      )
      return
    afterSelect: ->
      @qs1.cache()
      @qs2.cache()
      return
    afterDeselect: ->
      @qs1.cache()
      @qs2.cache()
      return
  )

	# filestyle init
	$(":file").filestyle
		icon: false,
		buttonText: "Seleccionar Archivo"

  # Custom brands preselections
  $(document).on 'click', '.btn-brand-preselect', (e) ->
    e.preventDefault()
    brand_ids = $(this).data("brand-ids")
    $('.multiselect1').multiSelect('select', brand_ids.split(",")) if brand_ids?

  # Deselect preselect button
  $(document).on 'click', '#btn-deselect', (e) ->
    e.preventDefault()
    $('.multiselect1').multiSelect('deselect_all')
    $('.search-input').val("");

  # Tooltip
  $ ->
    $('[data-toggle="tooltip"]').tooltip()
    return
