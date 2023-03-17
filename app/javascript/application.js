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