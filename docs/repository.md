# Debian Repository

The FruitNanny packages are provided as Debian packages and hosted as Debian
package repository via GitHub Pages.

```bash
# Add FruitNanny GPG key
curl -sL https://fruitnanny.github.io/pubkey.gpg | sudo apt-key add -

# Add FruitNanny repository
echo "deb https://fruitnanny.github.io/debian buster main" | sudo tee /etc/apt/sources.list.d/fruitnanny.list

# Update package index
sudo apt update

# Install FruitNanny packages
sudo apt install fruitnanny-api
```
