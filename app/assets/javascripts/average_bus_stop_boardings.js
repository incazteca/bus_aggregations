// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function updateRouteAggregation(event) {
  const chart = Chartkick.charts['route_agg_visualization'];
  const formParams = formData(event.currentTarget)

  const updatedChart = modifyChart(chart, formParams)
  updatedChart.refreshData()
  updatedChart.redraw()
}

function formData(aggregationForm) {
  const elems = aggregationForm.elements;
  let raw_params = {};

  for (let i=0; i < elems.length; i++) {
    raw_params[elems[i].name] = elems[i].value;
  }

  const params = {
    'aggregate_function': raw_params['aggregate_function[function]'],
    'aggregate_field': raw_params['aggregate_field[field]']
  }

  return params;
}

function modifyChart(chart, formParams) {
  const sourcePath = new URL('http://localhost' + chart.getDataSource()).pathname;
  const searchParams = new URLSearchParams(formParams);
  const updatedSource = sourcePath + '?' + searchParams.toString();

  const options = chart.getOptions();
  options['ytitle']  = formParams['aggregate_field'];

  chart.setOptions(options);
  chart.dataSource = updatedSource;

  return chart;
}

window.onload = function () {
  const route_aggregation_form = document.getElementById('route_agg_control');
  route_aggregation_form.addEventListener('submit', function(e) {
    e.preventDefault();
    updateRouteAggregation(e);
  });
}
