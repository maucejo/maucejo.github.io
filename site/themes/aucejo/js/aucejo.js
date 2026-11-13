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

  // Blog listing: free-text search, type tabs, and a tag filter set by the
  // tag links of posts. State lives in the URL hash (#type=… or #tag=…).
  function initPostFilters() {
    const filters = document.querySelector("[data-mx-post-filters]");
    const list = document.querySelector(".mx-posts");
    if (!filters || !list) return;

    const input = filters.querySelector(".mx-pub-search");
    const tabs = Array.from(filters.querySelectorAll("[data-filter]"));
    const empty = filters.querySelector(".mx-pub-empty");
    const tagBox = filters.querySelector(".mx-post-active-tag");
    const items = Array.from(list.querySelectorAll(".mx-post"));
    let type = "all";
    let tag = null;

    function apply() {
      const terms = (input?.value || "").toLowerCase().trim().split(/\s+/).filter(Boolean);
      let shown = 0;
      items.forEach((item) => {
        const okType = type === "all" || item.dataset.type === type;
        const okTag = !tag || (item.dataset.tags || "").split("|").includes(tag);
        const okSearch = terms.every((t) => item.dataset.search.includes(t));
        item.hidden = !(okType && okTag && okSearch);
        if (!item.hidden) shown += 1;
      });
      if (empty) empty.hidden = shown > 0;
      if (tagBox) {
        tagBox.hidden = !tag;
        tagBox.querySelector("strong").textContent = tag ? "#" + tag : "";
      }
      tabs.forEach((t) => {
        const on = t.dataset.filter === type;
        t.classList.toggle("is-active", on);
        t.setAttribute("aria-pressed", on ? "true" : "false");
      });
    }

    function writeHash() {
      const hash = tag ? "#tag=" + encodeURIComponent(tag)
        : type !== "all" ? "#type=" + encodeURIComponent(type) : "";
      history.replaceState(null, "", location.pathname + location.search + hash);
    }

    function readHash() {
      const m = location.hash.match(/^#(type|tag)=(.+)$/);
      const value = m ? decodeURIComponent(m[2]) : null;
      type = m && m[1] === "type" && tabs.some((t) => t.dataset.filter === value) ? value : "all";
      tag = m && m[1] === "tag" ? value : null;
      apply();
    }

    tabs.forEach((tab) => tab.addEventListener("click", () => {
      type = tab.dataset.filter;
      writeHash();
      apply();
    }));
    tagBox?.querySelector("button")?.addEventListener("click", () => {
      tag = null;
      writeHash();
      apply();
    });
    input?.addEventListener("input", apply);
    window.addEventListener("hashchange", readHash);
    readHash();
  }

  // "N min read" in the byline of a post, from its word count.
  function initReadingTime() {
    const target = document.querySelector(".mx-post-reading");
    const main = document.querySelector(".mx-main");
    if (!target || !main) return;
    const words = (main.innerText || "").trim().split(/\s+/).length;
    target.textContent = Math.max(1, Math.round(words / 220)) + " min read";
    target.hidden = false;
    const sep = document.querySelector(".mx-post-reading-sep");
    if (sep) sep.hidden = false;
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

  // Collapsible TOC: sub-entries are shown only while their parent section is
  // active. Calepin renders a flat list (li.level-N) and marks the current
  // link with a.active; this rebuilds the hierarchy and hides the entries
  // whose parent is not on the path to the active one.
  function initTocCollapse() {
    const nav = document.querySelector(".calepin-website-toc nav");
    if (!nav) return;
    const items = Array.from(nav.querySelectorAll("li")).map((li) => {
      const m = li.className.match(/\blevel-(\d+)\b/);
      return { li, level: m ? Number(m[1]) : 0, parent: null };
    });
    if (items.length < 2) return;

    const top = Math.min(...items.map((it) => it.level));
    const stack = [];
    for (const it of items) {
      while (stack.length && stack[stack.length - 1].level >= it.level) stack.pop();
      it.parent = stack[stack.length - 1] || null;
      stack.push(it);
    }

    function refresh() {
      const activeLi = nav.querySelector("a.active")?.closest("li");
      const open = new Set();
      for (let it = items.find((i) => i.li === activeLi); it; it = it.parent) open.add(it);
      for (const it of items) {
        it.li.classList.toggle("is-collapsed", it.level !== top && !open.has(it.parent));
      }
    }

    new MutationObserver((records) => {
      if (records.some((r) => r.target.tagName === "A")) refresh();
    }).observe(nav, { subtree: true, attributes: true, attributeFilter: ["class"] });
    refresh();
  }

  initPublicationFilters();
  initPostFilters();
  initReadingTime();
  initReveal();
  initTocCollapse();
})();
