const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello from the UAD Reference Implementation!');
});

// 🛑 VULNERABILITY: This route allows Remote Code Execution (RCE)
// Semgrep should catch the use of 'eval()' with user input.
app.get('/admin', (req, res) => {
  const userCommand = req.query.cmd;
  
  console.log("Executing admin command...");
  
  // This is the line that Policy v1.0 will BLOCK and v2.0 will NOT block
  eval(userCommand); 
  
  res.send('Command executed.');
});

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});