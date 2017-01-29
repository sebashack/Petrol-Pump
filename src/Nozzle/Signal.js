// -------------Helpers----------------->>
exports.signalNozzle = function(nozzle) {
  return function(price) {
    return function(constant) {
      var out = constant(0);
      var noz = document.getElementById(nozzle);
      var pri = document.getElementById(price);

      noz.addEventListener("click", function() {
	if (pri.dataset.pumping === "true") {
	  pri.dataset.pumping = "false";
	} else {
	  pri.dataset.pumping = "true";
	}
	out.set(0);
      }, false);

      return function() {
	return out;
      };

    };
  };
};

exports.displayPrice = function(price) {
  return function(r) {
    return function() {
      var pri = document.getElementById(price);
      var pumping = pri.dataset.pumping === "true" ? true : false;
      if(pumping) {
	var newPrice = parseFloat(pri.textContent) + r;
	pri.textContent = newPrice.toFixed(2);
      }
    };
  };
};

exports.displayTotal = function(price) {
  return function(r) {
    return function() {
      var total = document.getElementById("dollars");
      var pri = document.getElementById(price);
      var pumping = pri.dataset.pumping === "true" ? true : false;
      if(pumping) {
	var newTotal = parseFloat(total.textContent) + r;
	total.textContent = newTotal.toFixed(2);
      }
    };
  };
};
// <<-------------------------------------
