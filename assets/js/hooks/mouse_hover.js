export const MouseHover = {
  mounted() {
    this.el.addEventListener("mouseenter", event => {
      event.target.classList.add("scale-150")
    })
    this.el.addEventListener("mouseleave", event => {
      event.target.classList.remove("scale-150")
    })
  }
}
