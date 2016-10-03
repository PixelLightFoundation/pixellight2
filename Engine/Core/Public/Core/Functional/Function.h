#pragma once

#include <Core/Core.h>
#include <Core/Utils/TypeTraits.h>

namespace PixelLight
{
	namespace Internal
	{
		template <class R, class... Args>
		struct FunctionBase
		{
		public:
			template <class F, int S = sizeof(F)>
			void Reset(F func)
			{
				Storage<F, IsFunctionPtr<F>::Value>::Store(func, &_storage);
			}

			/*template <class F, int S = sizeof(F)>
			void Reset(F&& func)
			{
			Storage<F, IsFunctionV<F>>::Store(std::forward(func));
			}*/

			R operator()(Args... args)
			{
				if (_storage & 0x01)
				{
					typedef R(*fn)(Args...);
					fn f = (fn)(_storage & ~0x01);
					f(args...);
				}
				else
				{
					FuncImplBase* f = (FuncImplBase*)_storage;
					f->DoCall(args...);
				}
			}

			~FunctionBase()
			{
				if (!(_storage & 0x01))
				{
					FuncImplBase* f = (FuncImplBase*)_storage;
					delete f;
				}
			}

		private:
			class FuncImplBase
			{
			public:
				virtual ~FuncImplBase() {}
				virtual R DoCall(Args... args) = 0;
			};

			template <class T>
			class FuncImpl : public FuncImplBase
			{
			public:
				FuncImpl(T func) : _callable(func)
				{}

				virtual R DoCall(Args... args)
				{
					_callable(args...);
				}

			private:
				T _callable;
			};

			template <class T, bool IsFunction = false>
			struct Storage
			{
				static void Store(T func, intptr_t* dest)
				{
					// Generic storage using a virtual object
					*dest = (intptr_t)new FuncImpl<T>(func);
				}
			};

			template <class T>
			struct Storage<T, true>
			{
				static void Store(T func, intptr_t* dest)
				{
					// Optimized function pointer storage
					*dest = (intptr_t)func | 0x01;
				}
			};

			intptr_t _storage;
		};

		template <class T>
		struct GetFunctionType;

		template <class R, class... Args>
		struct GetFunctionType<R(Args...)>
		{
			typedef FunctionBase<R, Args...> Type;
		};
	}

	/**
	 *	Function object implementation
	 */
	template <class T>
	struct Function : public Internal::GetFunctionType<T>::Type
	{
		typedef Function<T> Type;
		typedef typename Internal::GetFunctionType<T>::Type FuncType;

		Function()
		{
		}

		Function(nullptr_t)
		{
		}

		Function(const Type& func)
		{
		}

		template <class F>
		Function(F func)
		{
			Reset(func);
		}

		/*template <class F>
		Function(F&& func)
		{
			Reset(std::forward(func));
		}*/
	};
}
