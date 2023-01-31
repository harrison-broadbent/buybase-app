// Copies the page URL to the clipboard when btn is clicked

var url = document.location.href;
let btn = document.getElementById("copy-url-btn")

new ClipboardJS(btn, {
    text: function() {
        return url;
    }
});

btn.addEventListener("click", function () {
    btn.innerText = "Copied link!"
})

btn.addEventListener("mouseout", function () {
    btn.innerText = "Share this database"
})