// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";
// import "../css/datepicker.min.css";

// import flatpickr from "flatpickr"

// const flatpickr = require('flatpickr')

// flatpickr("#date_format", {});
import "phoenix_html";
// import "bootstrap-datepicker";
// import $ from "jquery";

window.jQuery = window.$ = require('jquery');
// window.flatpickr = require('flatpickr');
import flatpickr from 'flatpickr';
flatpickr('#format_date', {enableTime: true, dateFormat: "Y-m-d H:i"});

// $('#date_format').datepicker({format:"yyyy-mm-dd"});

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//

// $(document).ready(() => {
//     $("#date_format").flatpickr({
//         noCalendar: false,
//         enableTime: true,
//         allowInput: true, 
//         dateFormat: 'M d, Y h i K'
//     })
// })

// $('#format_date').datepicker();

// $("#date_format").flatpickr();
// flatpickr("#date_format", {});


