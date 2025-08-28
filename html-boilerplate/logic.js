const container = document.querySelector("#container");

const content = document.createElement("div");
content.classList.add("content");
content.textContent = "This is the glorious text-content!";

const para = document.createElement("p");
para.textContent = "Hey I'm Red!";
para.style.color = "red";

const hhh = document.createElement("h3");
hhh.textContent = "I'm a blue h3!";
hhh.style.color = "blue";

const newDiv = document.createElement("div");
newDiv.setAttribute("style", "background: pink; border: solid black");

const h = document.createElement("h1");
h.textContent = "I'm in a div";
const p = document.createElement("p");
p.textContent = "ME TOOO!!!!!";


container.appendChild(content);
container.appendChild(para);
container.appendChild(hhh);


newDiv.appendChild(h); 
newDiv.appendChild(p);
container.appendChild(newDiv);

// the JavaScript file
const btn = document.querySelector("#btn");

btn.addEventListener("click", function (e) {
    e.target.style.background = "blue";
  });

// the JavaScript file
const btnn = document.querySelector("#btnn");
btnn.addEventListener("click", () => {
  alert("Hello World");
});


