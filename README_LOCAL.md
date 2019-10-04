ssh -i /home/jong/Downloads/readyplayercode.pem ubuntu@13.58.89.187
sudo passenger-config restart-app --instance oYlSfncL
sudo passenger-config restart-app --instance ZRlkAw9h
sudo service nginx restart
tail -f log/production.log 
