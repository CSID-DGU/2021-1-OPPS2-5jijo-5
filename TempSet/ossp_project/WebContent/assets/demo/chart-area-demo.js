// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart
var ctx = document.getElementById("myAreaChart");
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ["14:00:00", "14:05:00", "14:10:00", "14:15:00", "14:20:00", "14:25:00"],
    datasets: [{
      label: "Revenue",
      backgroundColor: "rgba(2,117,216,0.3)",
      borderColor: "rgba(2,117,216,1)",
      data: [15, 12, 21, 11, 21, 14],
    }],
  },
  options: {
    scales: {
      xAxes: [{
        time: {
          unit: 'time'
        },
        gridLines: {
          display: true
        },
        ticks: {
          maxTicksLimit: 8
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: 30,
          maxTicksLimit: 6
        },
        gridLines: {
          display: true
        }
      }],
    },
    legend: {
      display: false
    }
  }
});