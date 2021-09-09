#ifndef EDGEHANDLER_HPP
#define EDGEHANDLER_HPP

#include "MqttInterface.hpp"

namespace MessageHandler::Gateway
{
    class EdgeHandler : public MessageHandler::MqttInterface
    {
        Q_OBJECT

    public:
        explicit EdgeHandler(QString&, quint16&);
        void register_new_edge(QString&);

    public slots:
        void new_message(QMqttMessage) override;
        void heartbeat_received();
        //void on_get_edges();
    };
}

#endif // EDGEHANDLER_HPP
