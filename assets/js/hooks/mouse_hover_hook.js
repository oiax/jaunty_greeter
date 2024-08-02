export const MouseHoverHook = {
  mounted() {
    this.el.addEventListener("mouseenter", event => {
      event.target.classList.add("scale-125")
    })
    this.el.addEventListener("mouseleave", event => {
      event.target.classList.remove("scale-125")
    })
  }
}
