
// window.selectedCountContainer;
// window.selected;
// window.count;// = Number(selected.innerHTML);  

window.setVisibility = (value) => {
  document.querySelector(".selected-count-container").style.visibility = value === 0 ? "hidden" : "visible";
}

// window.setVisibility(count);

window.update_count = () => {
  const selectedCountContainer = document.querySelector(".selected-count-container");
  const selected = document.querySelector("#selected-count");
  const members = document.querySelectorAll(".form-check-input.member");
  let count = 0;
  for (let data of members) {
    if (data.checked)
      count++;
  }
  selected.innerHTML = count;
  document.querySelector("#selected-count").innerHTML = count;
  setVisibility(count);
  console.log("clicked", count, selected);
}

