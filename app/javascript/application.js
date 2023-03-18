// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import 'datasets/copy_url_to_clipboard'

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
        initializeDatasetForm() {
            console.log(gon.dataset_type)
            return gon.dataset_type
        },
        handleSelectChange() {
            console.log("handling change")
            let selectBox = document.getElementById("dataset_dataset_type")
            this.selectedDataType = selectBox.value
            console.log(this.selectedDataType, this.showFileField, this.showURLField)
        }
    },
    data() {
        return {
            // application menu
            showMenu: false,
            // edit/create
            selectedDataType: this.initializeDatasetForm(),
        }
    },
}).mount("#application")

console.log("mounted application vue app")

// datasets/show
// Copies the page URL to the clipboard when btn is clicked

let datasetURL = document.location.href;
let shareBtn = document.getElementById("copy-url-btn")

new ClipboardJS(shareBtn, {
    text: function() {
        return datasetURL;
    }
});

shareBtn.addEventListener("click", function () {
    shareBtn.lastChild.innerText = "Copied link!"
})

shareBtn.addEventListener("mouseout", function () {
    shareBtn.lastChild.innerText = "Share"
})