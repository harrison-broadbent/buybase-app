// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import 'datasets/copy_url_to_clipboard'
// import "@hotwired/turbo-rails"
import "chartkick"
import "Chart.bundle"

const { createApp } = Vue
import { directive } from "vue3-click-away";

createApp({
    directives: {
        ClickAway: directive
    },
    methods: {
        toggleShowMenu() {
            this.showMenu = !this.showMenu
        },
        closeMenu() {
            this.showMenu = false
        },
    },
    data() {
        return {
            // application menu
            showMenu: false,
        }
    }
}).mount("#desktop-menu")
console.log("mounted menu app")

// Paywall app
// show/hide paywall on store page
createApp({
    methods: {
        toggleShowPaywall() {
            this.showPaywall = !this.showPaywall
        },
        closePaywall() {
            this.showPaywall = false
        },
    },
    data() {
        return {
            // application menu
            showPaywall: false,
        }
    }
}).mount("#paywall-purchase-page")
console.log("mounted paywall app")

createApp({
    methods: {
        initializeDatasetForm() {
            console.log(gon.dataset_type)
            return gon.dataset_type
        },
        handleSelectChange() {
            console.log("handling change")
            let selectBox = document.getElementById("dataset_dataset_type")
            this.selectedDataType = selectBox.value
            console.log(this.selectedDataType, this.showFileField, this.showURLField)
        },
    },
    data() {
        return {
            // edit/create
            selectedDataType: this.initializeDatasetForm(),
        }
    },
}).mount("#dataset-form")
console.log("mounted dataset vue app")


createApp({
    data() {
        return {
            table_data: gon.table_data,
            headers: Object.keys(gon.table_data[0]),
            active_sort_direction: "desc",
            active_sort_heading: null,
        }
    },
    methods: {
        sortTableData(key) {
            console.log(this, this.table_data)
            // data is an array of "col#" hashes, which we want to sort asc/desc by "key"
            let td = _.sortBy(this.table_data, key)

            // if we sorted by this col last time, sort the other way (asc/desc)
            if (this.active_sort_heading !== key) {
                this.active_sort_heading = key
                this.active_sort_direction = "desc"
            } else {
                this.active_sort_direction === "desc" ? this.active_sort_direction = "asc" : this.active_sort_direction = "desc"
            }

            this.active_sort_direction === "asc" ? td.reverse() : td
            this.table_data = td
        }
    }
}).mount("#data-table")
console.log("mounted table vue")


// datasets/show
// Copies the page URL to the clipboard when btn is clicked

let datasetURL = document.location.href;
let shareBtn = document.getElementById("copy-url-btn")

let clipboard = new ClipboardJS(shareBtn, {
    text: function() {
        return datasetURL;
    }
});

clipboard.on('success', function(e) {
    e.trigger.lastChild.innerText = 'Copied link!'
    setTimeout(() => e.trigger.lastChild.innerText = "Copy link", 1000)
});