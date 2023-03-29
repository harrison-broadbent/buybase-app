# Pin npm packages by running ./bin/importmap

pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin_all_from "app/javascript/datasets", under: "datasets"
pin "vue3-click-away", to: "https://ga.jspm.io/npm:vue3-click-away@1.2.4/dist/module.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "application", preload: true
