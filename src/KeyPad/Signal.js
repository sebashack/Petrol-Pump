exports.signalKey = function(k) {
  return function(constant) {
    var out = constant(0);
    var key = document.getElementById(k);

    key.addEventListener('click', function() {
      if(k === "clear") {
	out.set(0);
      } else {
        out.set(parseInt(key.firstChild.textContent, 10));
      }
    }, false);

    return function() {
      return out;
    };
  };
};

exports.displayPreset = function(r) {
  return function() {
    var content = document.getElementById('preset');
    if (content.textContent.length < 10) {
      var oldVal = parseFloat(content.textContent, 10);
      var newVal =  (oldVal * 10) + r;
      content.textContent = newVal;
      if (oldVal === 0 && newVal === 0) {
	content.textContent = "0.00";
      }
    }
  };
};

exports.getPresetVal = function() {
  return function() {
    var content = document.getElementById('preset');
    return parseFloat(content.textContent, 10);
  };
};

exports.clearPreset = function(r) {
  return function() {
    document.getElementById('preset').textContent = "0.00";
    document.getElementById('liters').textContent = "0.00";
    document.getElementById('dollars').textContent = "0.00";
    document.getElementById('price1').textContent = "0.00";
    document.getElementById('price2').textContent = "0.00";
    document.getElementById('price3').textContent = "0.00";
  };
};
