# Hybrid Minecraft Server Network (Velocity + Paper)

This project showcases a professional-grade Minecraft server architecture designed for **Hybrid Authentication** (supporting both Premium and Cracked players) with secure tunneling for global access.

## 🚀 Key Technical Features

### 1. High-Performance Proxy Architecture
*   **Velocity Proxy:** Utilizes the modern, high-performance Velocity proxy for optimized packet handling and player routing.
*   **IP Forwarding (Modern):** Implements Velocity's "Modern" forwarding mode to securely pass player UUIDs and IP addresses to backend servers.
*   **Sequential Startup:** Automated PowerShell scripts ensure the proxy initializes fully before backend servers, preventing handshake failures.

### 2. Hybrid Authentication Stack
*   **Premium Auto-Login:** Integrated with **FastLogin** to automatically verify Mojang sessions for official accounts.
*   **Cracked Support:** Configured with **AuthMe Reloaded** to provide a secure registration/login system for offline-mode players.
*   **Skin Synchronization:** Utilizes **SkinsRestorer** to ensure consistent player appearances across the entire network.

### 3. Networking & Tunneling
*   **playit.gg Integration:** Secured global access using a dedicated tunneling agent, bypassing the need for manual port forwarding while maintaining a static public address.
*   **Persistence:** Custom startup scripts ensure the tunnel agent maintains its identity and configuration across restarts.

### 4. Automation & DevOps
*   **PowerShell Orchestration:** Custom scripts for automated deployment, dependency management (SQLite JDBC fixes), and network-wide restarts.
*   **Optimized Timeouts:** Fine-tuned network buffers and keepalive thresholds to handle high-latency connections over international tunnels.

## 🛠️ Prerequisites
*   **Java 21 or 25 (LTS):** Required to run the Velocity and Paper jars.
*   **playit.gg Account:** Needed to claim the tunnel agent for public access.

## 📂 Project Structure
*   `1_Velocity_Proxy/`: The entry point for all players.
*   `2_Paper_Server/`: The high-performance game instance (Lobby).
*   `deploy.ps1`: One-click setup (Generates secrets, downloads tunnel).
*   `restart_all.bat`: One-click sequential startup for all components.

## 🚀 Quick Start (Deployment)

1.  **Clone the Repo:** `git clone https://github.com/YOUR_USERNAME/Hybrid-Minecraft-Network.git`
2.  **Deploy:** Right-click `deploy.ps1` and select **Run with PowerShell**.
    *   *This will generate your unique secrets and download the tunnel agent.*
3.  **Start:** Run `restart_all.bat`.
4.  **Claim:** Click the link in the playit.gg window to get your public server address.

---
*Developed as a technical showcase for Minecraft Server Administration and Networking.*
