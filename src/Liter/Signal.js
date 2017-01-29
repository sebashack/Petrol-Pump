exports.displayLiters = function(price) {
  return function(r) {
    return function() {
      var liters = document.getElementById('liters');
      var pri = document.getElementById(price);
      var pumping = pri.dataset.pumping === "true" ? true : false;
      if(pumping) {
	var newLoad = parseFloat(liters.textContent) + r;
	liters.textContent = newLoad.toFixed(2);
      }
    };
  };
};
