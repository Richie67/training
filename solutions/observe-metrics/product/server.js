'use strict';

const express = require('express');
var prometheus = require('prom-client');
const prefix = 'product_svc_';
prometheus.collectDefaultMetrics({ prefix });

const app = express();

app.listen(8080, function () {
    console.log('product-svc started on port 8080');
})

const responseTime = new prometheus.Gauge({
    name: 'product_svc:spl50_response_time',
    help: 'Time take in seconds to render the 50% special offer page'
});

const page_views = new prometheus.Counter({
    name: 'product_svc:spl50_page_view_count',
    help: 'No of page views for the 50% special offer page'
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

app.get('/', function (req, res) {
    res.send('Welcome to the Istio store!\n');
})

app.get('/spl50', async function (req, res) {
    responseTime.setToCurrentTime();
    const end = responseTime.startTimer();
    page_views.inc();
    const view_msg = '50% off on purchase of 100 or more items!\n' + 'Hurry! Limited stocks...\n';
    // sleep a little
    await sleep(Math.floor(Math.random() * 200) + 1);
    end();
    res.send(view_msg);
})

app.get('/metrics', function (req, res) {

    res.set('Content-Type', prometheus.register.contentType);
    res.send(prometheus.register.metrics());
})


