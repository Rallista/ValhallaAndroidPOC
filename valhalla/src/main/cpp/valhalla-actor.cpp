

#include <valhalla/tyr/actor.h>
#include <valhalla/baldr/rapidjson_utils.h>
#include <valhalla/loki/worker.h>

class ValhallaActor {
public:
    std::string route(const std::string& request, const std::string& config_path) {
        // Get the config path
        std::string config_file(config_path);
        
        // Set up the config object
        boost::property_tree::ptree(config);
        rapidjson::read_json(config_file, config);
        
        // Setup the actor
        tyr::actor_t actor = tyr::actor_t(config);
        
        // Convert the request to a std::string
        std::string req = std::string([request UTF8String]);
        
        // Produce the route result
        std::string result = actor.route(req);
        
        return result;
    }
};
