// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function updateRouteAggregation(event){
  const chart = Chartkick.charts['route_agg_visualization'];
  console.log(chart)
  console.log(event)
}

window.onload = function () {
  const route_aggregation_form = document.getElementById('route_agg_control');
  route_aggregation_form.addEventListener('submit', function(e){updateRouteAggregation(e)});
}
