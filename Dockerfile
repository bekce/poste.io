FROM analogic/poste.io
RUN touch /etc/services.d/clamd/down
RUN sed -i'' 's/^virus\/clamdscan/#virus\/clamdscan/' /etc/qpsmtpd/plugins
