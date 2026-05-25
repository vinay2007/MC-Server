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
*   `setup_network.ps1`: Automated builder for the network environment.
*   `restart_all.bat`: One-click sequential startup for all components.

---
*Developed as a technical showcase for Minecraft Server Administration and Networking.*
