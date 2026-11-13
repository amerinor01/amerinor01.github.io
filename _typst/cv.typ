// CV rendered from the same data as the /cv/ page (_data/cv.yml).
// Build: typst compile --root . _typst/cv.typ assets/pdf/cv.pdf

#import "@preview/basic-resume:0.2.9": *

#let cv = yaml("../_data/cv.yml")
#let socials = yaml("../_data/socials.yml")
#let site = read("../CNAME").trim()

// cv.yml may contain inline <a href="...">text</a>; turn those into links.
#let rich(s) = {
  if type(s) != str { return s }
  let re = regex("<a href=\"([^\"]+)\"[^>]*>(.*?)</a>")
  let out = ()
  let pos = 0
  for m in s.matches(re) {
    out.push(s.slice(pos, m.start))
    out.push(link(m.captures.at(0), m.captures.at(1)))
    pos = m.end
  }
  out.push(s.slice(pos))
  out.join()
}

#let items(d) = if d == none { () } else if type(d) == array { d } else { (d,) }
#let dates(e) = str(e.at("year", default: "")).replace(" - ", " \u{2014} ")
#let opt(e, key) = e.at(key, default: "")

#let info = {
  let s = cv.find(s => s.title == "General Information")
  let d = (:)
  for c in s.contents { d.insert(c.name, c.value) }
  d
}

#show: resume.with(
  author: info.at("Full Name"),
  location: info.at("Location", default: ""),
  email: socials.at("email", default: ""),
  github: "github.com/" + socials.github_username,
  linkedin: "linkedin.com/in/" + socials.linkedin_username,
  personal-site: site,
  accent-color: "#26428b",
  font: "New Computer Modern",
  paper: "us-letter",
  author-position: left,
  personal-info-position: left,
)

#let render(section) = {
  heading(level: 2, section.title)
  if section.type == "time_table" {
    for e in section.contents {
      if section.title == "Education" {
        edu(
          institution: opt(e, "institution"),
          location: opt(e, "location"),
          dates: dates(e),
          degree: e.title,
        )
      } else if "role" in e {
        project(role: e.role, name: rich(e.title), dates: dates(e))
      } else {
        work(
          title: e.title,
          location: opt(e, "location"),
          company: opt(e, "institution"),
          dates: dates(e),
        )
      }
      list(..items(e.at("description", default: none)).map(rich))
    }
  } else if section.type == "map" {
    list(..section.contents.map(c => [*#c.name*: #rich(c.value)]))
  } else if section.type == "nested_list" {
    list(..section.contents.map(c => {
      rich(c.title)
      let sub = items(c.at("items", default: none))
      if sub.len() > 0 { list(..sub.map(rich)) }
    }))
  } else if section.type == "list" {
    list(..section.contents.map(rich))
  }
}

// These go last, after the publications, in this order.
#let tail = ("Talks", "Open Source")
#let sections = cv.filter(s => s.title != "General Information" and s.at("pdf", default: true))

#for section in sections.filter(s => s.title not in tail) { render(section) }

== Publications
#bibliography("../_bibliography/papers.bib", title: none, full: true, style: "ieee")

#for title in tail {
  let section = sections.find(s => s.title == title)
  if section != none { render(section) }
}
