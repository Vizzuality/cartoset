/*! mamuso (http://mamuso.net)
* Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
* and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
*
* Version: 0.0.1
* Requires jQuery 1.3+
*--------------------------------------------------------------------------*/
(function($) {
    $.fn.prettyfile = function (opts) {
    var defaults = {
      setvalue: true,
      html: "<span class='pf_ph'>Browse files</span>",
      phclass: "pf_ph",
      phcontclass: "pf_ph_cont",
      wrapclass: "pf_wrap_class",
      selectedclass: "selected"
    },
    options = jQuery.extend(defaults, opts || {});

    return this.each(function () {
      var _self = $(this),
          _wrap = $("<span class='" + options.wrapclass + "'></span>"),
          _fakeinput = $("<span class='" + options.phcontclass + "'></span>"),
          _selfparent,
          _ph;

      _wrap.css({"position": "relative", "overflow": "hidden", "display": "block"});
      _self.css({"position": "absolute", "margin": 0, "padding": 0, "right": 0, "top": 0, "font-size": "100em", "z-index": 3, "width": "auto", "opacity": 0});
      _fakeinput.append(options.html);
      _self.wrap(_wrap).after(_fakeinput);

      _selfparent = _self.parent();

      _fakeinput = $("." + options.phcontclass, _selfparent);
      _selfparent.css({"height": _fakeinput.height() + "px", "width": _fakeinput.width() + "px"});

      // trigering change
      _ph = $("." + options.phclass, _selfparent);
      _self.change(function () {
        if (this.value !== undefined) {
          _selfparent.addClass(options.selectedclass)
        }
        if(options.setvalue && _ph.length > 0) {
          _ph.html(this.value);
          // change width if is a flexible input
          _selfparent.css("width", _fakeinput.width() + "px");
        }
      });
    });
  };
})(jQuery);