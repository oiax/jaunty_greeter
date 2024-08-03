export const FadeOut = {
  mounted() {
    const target = this.el
    const tab = document.querySelector("input[aria-label='Fade out']")
    const delay = parseInt(target.dataset.delay)

    if (tab && Number.isInteger(delay) && delay > 0) {
      tab.addEventListener("change", _event => {
        target.classList.add("transition", "duration-1000")
        target.classList.remove("opacity-0")
        setTimeout(() => target.classList.add("opacity-0"), delay)
      })
    }
  }
}
