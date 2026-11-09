// aucejo theme: publication filters and scroll reveal.
(() => {
  "use strict";

  // Show each year only once in consecutive publication entries.
  function markRepeatedYears(list) {
    let previous = null;
    list.querySelectorAll(".mx-pub:not([hidden])").forEach((item) => {
      const year = item.querySelector(".mx-pub-year");
      if (!year) return;
      year.classList.toggle("is-repeat", item.dataset.year === previous);
      previous = item.dataset.year;
    });
  }

  function initPublicationFilters() {
    const filters = document.querySelector("[data-mx-pub-filters]");
    const list = document.querySelector(".mx-pubs");
    if (!list) return;
    markRepeatedYears(list);
    if (!filters) return;

    const input = filters.querySelector(".mx-pub-search");
    const tabs = Array.from(filters.querySelectorAll("[data-filter]"));
    const empty = filters.querySelector(".mx-pub-empty");
    const items = Array.from(list.querySelectorAll(".mx-pub"));
    let category = "all";

    function apply() {
      const terms = (input?.value || "").toLowerCase().trim().split(/\s+/).filter(Boolean);
      let shown = 0;
      items.forEach((item) => {
        const okCategory = category === "all" || item.dataset.category === category;
        const haystack = item.dataset.search + " " + item.dataset.year;
        const okSearch = terms.every((t) => haystack.includes(t));
        item.hidden = !(okCategory && okSearch);
        if (!item.hidden) shown += 1;
      });
      if (empty) empty.hidden = shown > 0;
      markRepeatedYears(list);
    }

    tabs.forEach((tab) => {
      tab.addEventListener("click", () => {
        category = tab.dataset.filter;
        tabs.forEach((t) => {
          t.classList.toggle("is-active", t === tab);
          t.setAttribute("aria-pressed", t === tab ? "true" : "false");
        });
        apply();
      });
    });
    input?.addEventListener("input", apply);
  }

  function initReveal() {
    if (!("IntersectionObserver" in window)) return;
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
    const sections = document.querySelectorAll(".mx-home .mx-section, .mx-main > .mx-section");
    if (!sections.length) return;
    document.documentElement.classList.add("js-reveal");
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        }
      });
    }, { rootMargin: "0px 0px -8% 0px", threshold: 0.05 });
    sections.forEach((s) => observer.observe(s));
  }

  initPublicationFilters();
  initReveal();
})();
