#include "mysql/psi/psi_stage.h"
#include "my_inttypes.h"
#include "my_config.h"
typedef unsigned char uchar;
typedef signed char int8;
typedef unsigned char uint8;
typedef short int16;
typedef unsigned short uint16;
typedef int int32;
typedef unsigned int uint32;
typedef unsigned long long int ulonglong;
typedef long long int longlong;
typedef longlong int64;
typedef ulonglong uint64;
typedef unsigned long long my_ulonglong;
typedef intptr_t intptr;
typedef ulonglong my_off_t;
typedef ptrdiff_t my_ptrdiff_t;
typedef int myf;
#include "my_macros.h"
#include "my_psi_config.h"
#include "my_sharedlib.h"
#include "mysql/components/services/psi_stage_bits.h"
typedef unsigned int PSI_stage_key;
struct PSI_stage_progress_v1 {
  unsigned long long m_work_completed;
  unsigned long long m_work_estimated;
};
typedef struct PSI_stage_progress_v1 PSI_stage_progress_v1;
struct PSI_stage_info_v1 {
  PSI_stage_info_v1() {}
  PSI_stage_info_v1(PSI_stage_key key, const char *name, unsigned int flags,
                    const char *documentation)
      : m_key(key),
        m_name(name),
        m_flags(flags),
        m_documentation(documentation) {}
  PSI_stage_key m_key{0};
  const char *m_name{nullptr};
  unsigned int m_flags{0};
  const char *m_documentation{nullptr};
};
typedef struct PSI_stage_info_v1 PSI_stage_info_v1;
typedef void (*register_stage_v1_t)(const char *category,
                                    struct PSI_stage_info_v1 **info, int count);
typedef PSI_stage_progress_v1 *(*start_stage_v1_t)(PSI_stage_key key,
                                                   const char *src_file,
                                                   int src_line);
typedef PSI_stage_progress_v1 *(*get_current_stage_progress_v1_t)(void);
typedef void (*end_stage_v1_t)(void);
typedef struct PSI_stage_info_v1 PSI_stage_info;
typedef struct PSI_stage_progress_v1 PSI_stage_progress;
#include "psi_base.h"
#include "my_psi_config.h"
struct PSI_placeholder {
  int m_placeholder;
};
struct PSI_stage_bootstrap {
  void *(*get_interface)(int version);
};
struct PSI_stage_service_v1 {
  register_stage_v1_t register_stage;
  start_stage_v1_t start_stage;
  get_current_stage_progress_v1_t get_current_stage_progress;
  end_stage_v1_t end_stage;
};
typedef struct PSI_stage_service_v1 PSI_stage_service_t;
extern PSI_stage_service_t *psi_stage_service;
