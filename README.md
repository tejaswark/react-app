# sample-react

Minimal React app used in a Jenkins -> EC2 deployment demo.

## Scripts
- `npm start` — local dev
- `npm run build` — production build

The Jenkins pipeline copies the `build/` output to the EC2 server and serves it via `serve -s` on port 3000.
