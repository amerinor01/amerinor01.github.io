// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-publications",
          title: "publications",
          description: "publications by categories in reversed chronological order.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/publications/";
          },
        },{id: "nav-projects",
          title: "projects",
          description: "Research software I develop and contribute to.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/projects/";
          },
        },{id: "nav-cv",
          title: "cv",
          description: "",
          section: "Navigation",
          handler: () => {
            window.location.href = "/cv/";
          },
        },{id: "news-i-was-a-speaker-at-the-cern-summer-stem-academy-2026-where-i-presented-inasim-as-an-open-source-network-simulator-and-taught-a-2-hour-hands-on-session-practice-networking-simulation",
          title: 'I was a speaker at the CERN Summer STEM Academy 2026, where I...',
          description: "",
          section: "News",},{id: "news-new-preprint-out-pcm-programmable-congestion-management-for-terabit-rdma-nics-a-portable-programming-model-for-congestion-control-and-load-balancing-on-datacenter-nics-evaluated-on-nvidia-connectx-8-microsoft-1p-uccl-and-an-ultra-ethernet-simulator",
          title: 'New preprint out: PCM: Programmable Congestion Management for Terabit RDMA NICs, a portable...',
          description: "",
          section: "News",},{id: "projects-inasim",
          title: 'INASim',
          description: "Interconnection network simulator for HPC and data-center networks",
          section: "Projects",handler: () => {
              window.location.href = "/projects/inasim/";
            },},{
      id: 'light-theme',
      title: 'Change theme to light',
      description: 'Change the theme of the site to Light',
      section: 'Theme',
      handler: () => {
        setThemeSetting("light");
      },
    },
    {
      id: 'dark-theme',
      title: 'Change theme to dark',
      description: 'Change the theme of the site to Dark',
      section: 'Theme',
      handler: () => {
        setThemeSetting("dark");
      },
    },
    {
      id: 'system-theme',
      title: 'Use system default theme',
      description: 'Change the theme of the site to System Default',
      section: 'Theme',
      handler: () => {
        setThemeSetting("system");
      },
    },];
